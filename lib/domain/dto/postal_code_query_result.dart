import 'package:consumer_pingou_com/domain/enums/address_state.dart';

class PostalCodeQueryResult {
  final String street;
  final String neighborhood;
  final String city;
  final AddressState state;

  PostalCodeQueryResult({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
  });
}
