import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:flutter/material.dart';

class CardBrandIcon extends StatelessWidget {
  final CardBrand brand;

  const CardBrandIcon({
    super.key,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar;

    switch (brand) {
      case CardBrand.elo:
        avatar = Image.asset(
          'assets/img/card-brands/elo.png',
          height: 32,
          width: 32,
        );
        break;
      case CardBrand.mastercard:
        avatar = Image.asset(
          'assets/img/card-brands/mastercard.png',
          height: 32,
          width: 32,
        );
        break;
      case CardBrand.visa:
        avatar = Image.asset(
          'assets/img/card-brands/visa.png',
          height: 32,
          width: 32,
        );
        break;
      default:
        avatar = const Icon(Icons.credit_card);
        break;
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.white,
      child: avatar,
    );
  }
}
