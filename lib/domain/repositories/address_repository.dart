import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';

abstract class AddressRepository {
  Future<PostalCodeQueryResult?> queryPostalCode(String postalCode);
}
