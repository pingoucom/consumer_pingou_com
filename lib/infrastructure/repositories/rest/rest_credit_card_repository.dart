import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';
import 'package:consumer_pingou_com/http.dart';

class RestCreditCardRepository implements CreditCardRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<CreditCard> add(CreditCardInput input) async {
    final uri = Uri.parse('$_apiUrl/credit-card-store');

    final request =
        HttpRequestExecutor.prepareRequest(await _httpClient.postUrl(uri));

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'number': input.number,
      'holderName': input.holderName,
      'expirationDate': input.expirationDate,
      'cvv': input.cvv,
    }));

    final response = await request.close();
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return CreditCard(
      id: data['id'],
      brand: CardBrand.values.firstWhere(
        (s) => s.toString().split('.').last.toLowerCase() == data['brand'],
      ),
      lastFourDigits: data['lastFourDigits'],
      holderFirstName: data['holder_first_name'],
    );
  }

  @override
  Future<List<CreditCard>> getAll() async {
    final uri = Uri.parse('$_apiUrl/credit-card-index');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => CreditCard(
        id: data[index]['id'],
        brand: CardBrand.values.firstWhere(
          (s) =>
              s.toString().split('.').last.toLowerCase() ==
              data[index]['brand'],
        ),
        lastFourDigits: data[index]['lastFourDigits'],
        holderFirstName: data[index]['holder_first_name'],
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    final uri = Uri.parse('$_apiUrl/credit-card-delete?id=$id');

    final request = await _httpClient.deleteUrl(uri);
    await HttpRequestExecutor.execute(request);
  }
}
