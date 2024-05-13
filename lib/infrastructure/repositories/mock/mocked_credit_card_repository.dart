import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';

class MockedCreditCardRepository implements CreditCardRepository {
  final Random _random = Random();

  @override
  Future<CreditCard> add(CreditCardInput input) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => CreditCard(
        id: (_random.nextInt(1000) + 1000).toString(),
        brand: CardBrand.values[_random.nextInt(CardBrand.values.length)],
        lastFourDigits: input.number.substring(input.number.length - 4),
        holderFirstName: input.holderName.split(' ').first,
      ),
    );
  }
}
