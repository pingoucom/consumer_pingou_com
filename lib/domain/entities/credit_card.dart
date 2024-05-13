import 'package:consumer_pingou_com/domain/enums/card_brand.dart';

class CreditCard {
  final String id;
  final CardBrand brand;
  final String lastFourDigits;
  final String holderFirstName;

  CreditCard({
    required this.id,
    required this.brand,
    required this.lastFourDigits,
    required this.holderFirstName,
  });
}
