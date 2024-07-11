import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:consumer_pingou_com/http.dart';

class RestAddressRepository implements AddressRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<PostalCodeQueryResult?> queryPostalCode(String postalCode) async {
    final sanitizedPostalCode = postalCode.replaceAll(RegExp(r'\D'), '');
    final uri =
        Uri.parse('https://viacep.com.br/ws/$sanitizedPostalCode/json/');

    try {
      final request = await _httpClient.getUrl(uri);
      final response = await request.close();
      final data = jsonDecode(await response.transform(utf8.decoder).join());

      return PostalCodeQueryResult(
        street: data['logradouro'],
        neighborhood: data['bairro'],
        city: data['localidade'],
        state: AddressState.values.firstWhere(
          (s) => s.toString().split('.').last.toUpperCase() == data['uf'],
        ),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Address> add(AddressInput input) async {
    final uri = Uri.parse('$_apiUrl/address-store');

    final request =
        HttpRequestExecutor.prepareRequest(await _httpClient.postUrl(uri));

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'street': input.street,
      'number': input.number,
      'complement': input.complement,
      'neighborhood': input.neighborhood,
      'city': input.city,
      'state': input.state.toString().split('.').last.toUpperCase(),
      'postalCode': input.postalCode,
    }));

    final response = await request.close();
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return Address(
      id: data['id'],
      street: data['street'],
      number: data['number'],
      complement: data['complement'],
      neighborhood: data['neighborhood'],
      city: data['city'],
      state: AddressState.values.firstWhere(
        (s) => s.toString().split('.').last.toUpperCase() == data['state'],
      ),
      postalCode: data['postalCode'],
    );
  }

  @override
  Future<Address> update(String id, AddressInput input) async {
    final uri = Uri.parse('$_apiUrl/address-update?id=$id');

    final request =
        HttpRequestExecutor.prepareRequest(await _httpClient.putUrl(uri));
    request.headers.add('Content-Type', 'application/json');
    request.write(jsonEncode({
      'street': input.street,
      'number': input.number,
      'complement': input.complement,
      'neighborhood': input.neighborhood,
      'city': input.city,
      'state': input.state.toString().split('.').last.toUpperCase(),
      'postalCode': input.postalCode,
    }));

    await request.close();

    return Address(
      id: id,
      street: input.street,
      number: input.number,
      complement: input.complement,
      neighborhood: input.neighborhood,
      city: input.city,
      state: input.state,
      postalCode: input.postalCode,
    );
  }

  @override
  Future<List<Address>> getUserAddresses() async {
    final uri = Uri.parse('$_apiUrl/address-index');

    final request = await _httpClient.getUrl(uri);
    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List<Address>.from(data.map((address) => Address(
          id: address['id'],
          street: address['street'],
          number: address['number'].toString(),
          complement: address['complement'],
          neighborhood: address['neighborhood'],
          city: address['city'],
          state: AddressState.values.firstWhere(
            (s) =>
                s.toString().split('.').last.toUpperCase() == address['state'],
          ),
          postalCode: address['postalCode'],
        )));
  }

  @override
  Future<void> delete(String id) async {
    final uri = Uri.parse('$_apiUrl/address-delete?id=$id');

    final request = await _httpClient.deleteUrl(uri);
    await HttpRequestExecutor.execute(request);
  }
}
