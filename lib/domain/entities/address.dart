import 'package:consumer_pingou_com/domain/enums/address_state.dart';

class Address {
  final String street;
  final String number;
  final String? complement;
  final String neighborhood;
  final String city;
  final AddressState state;
  final String postalCode;

  Address({
    required this.street,
    required this.number,
    this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.postalCode,
  });
}
