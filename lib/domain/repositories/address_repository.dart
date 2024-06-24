import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';

abstract class AddressRepository {
  Future<PostalCodeQueryResult?> queryPostalCode(String postalCode);

  Future<Address> add(AddressInput input);

  Future<Address> update(Address address, AddressInput input);
}
