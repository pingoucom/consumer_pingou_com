import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';

class MockedAddressRepository implements AddressRepository {
  final Random _random = Random();

  @override
  Future<PostalCodeQueryResult> queryPostalCode(String postalCode) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => PostalCodeQueryResult(
        street: 'Rua dos Bobos',
        neighborhood: 'Bairro Feliz',
        city: 'Cidade Alegre',
        state: AddressState.values[_random.nextInt(AddressState.values.length)],
      ),
    );
  }
}
