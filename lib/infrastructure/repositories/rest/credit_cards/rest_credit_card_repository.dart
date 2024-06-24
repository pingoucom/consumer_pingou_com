import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';

class RestCreditCardRepository implements CreditCardRepository {
  final baseUri = 'http://10.0.2.2:8080/pingou/users/wallet';

  final HttpClient _httpClient = HttpClient();

  @override
  Future<CreditCard> add(CreditCardInput input) async {
    final request = await _httpClient.postUrl(Uri.parse(baseUri));
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'usuario_id': input.userId != '0' ? input.userId : '1',
      'numero': input.number,
      'nome': input.holderName,
      'data_vencimento': input.expirationDate,
      'bandeira': 'mastercard',
      'preferido': 0,
    }));

    final response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('Failed to add credit card');
    }

    return CreditCard(
      id: Random().nextInt(1000).toString(),
      brand: CardBrand.mastercard,
      lastFourDigits: input.number.substring(input.number.length - 4),
      holderFirstName: input.holderName.split(' ').first,
    );
  }
}
