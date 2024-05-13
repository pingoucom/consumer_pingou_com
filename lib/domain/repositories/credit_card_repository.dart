import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';

abstract class CreditCardRepository {
  Future<CreditCard> add(CreditCardInput input);
}
