import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';

class MockedAddressRepository implements AddressRepository {
  final Random _random = Random();
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
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => Address(
        id: (_random.nextInt(1000) + 1000).toString(),
        street: input.street,
        number: input.number,
        neighborhood: input.neighborhood,
        city: input.city,
        state: input.state,
        postalCode: input.postalCode,
      ),
    );
  }

  @override
  Future<Address> update(String id, AddressInput input) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => Address(
        id: id,
        street: input.street,
        number: input.number,
        neighborhood: input.neighborhood,
        city: input.city,
        state: input.state,
        postalCode: input.postalCode,
      ),
    );
  }
}
