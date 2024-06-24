import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';

class RestAddressRepository implements AddressRepository {
  final baseUri = 'http://10.0.2.2:8080/pingou/users/enderecos';

  final HttpClient _httpClient = HttpClient();

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
    final request = await _httpClient.postUrl(Uri.parse(baseUri));
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'usuario_id': input.userId != '0' ? input.userId : '1',
      'rua': input.street,
      'numero': input.number,
      'bairro': input.neighborhood,
      'cidade': input.city,
      'estado': input.state.name,
      'cep': input.postalCode,
    }));

    final response = await request.close();

    if (response.statusCode != 201) {
      throw Exception('Failed to add address');
    }

    return Address(
      id: Random().nextInt(1000).toString(),
      street: input.street,
      number: input.number,
      neighborhood: input.neighborhood,
      city: input.city,
      state: input.state,
      postalCode: input.postalCode,
    );
  }

  @override
  Future<Address> update(Address address, AddressInput input) async {
    final uri = Uri.parse('$baseUri/update');
    uri.queryParameters.addAll({
      'rua': input.street,
      'numero': input.number,
      'bairro': input.neighborhood,
      'cidade': input.city,
      'estado': input.state.name,
      'cep': input.postalCode,
    });

    final request = await _httpClient.postUrl(uri);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'usuario_id': input.userId != '0' ? input.userId : '1',
      'rua': input.street,
      'numero': input.number,
      'bairro': input.neighborhood,
      'cidade': input.city,
      'estado': input.state,
      'cep': input.postalCode,
    }));

    final response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('Failed to add credit card');
    }

    return Address(
      id: address.id,
      street: input.street,
      number: input.number,
      neighborhood: input.neighborhood,
      city: input.city,
      state: input.state,
      postalCode: input.postalCode,
    );
  }
}
