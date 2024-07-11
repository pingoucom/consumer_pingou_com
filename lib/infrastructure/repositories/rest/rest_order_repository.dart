import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/enums/order_status.dart';
import 'package:consumer_pingou_com/domain/repositories/order_repository.dart';
import 'package:consumer_pingou_com/http.dart';

class RestOrderRepository implements OrderRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<List<Order>> get() async {
    final uri = Uri.parse('$_apiUrl/order-index');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => _parseOrder(data[index]),
    );
  }

  @override
  Future<Order?> find(String orderId) async {
    final uri = Uri.parse('$_apiUrl/order-details?id=$orderId');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return _parseOrder(data);
  }

  @override
  Future<Order> add(
    Map<Product, double> items,
    Address address,
    CreditCard creditCard,
  ) async {
    final uri = Uri.parse('$_apiUrl/order-store');

    final request =
        HttpRequestExecutor.prepareRequest(await _httpClient.postUrl(uri));

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({
      'items': items.map((key, value) => MapEntry(key.id, value)),
      'addressId': address.id,
      'creditCardId': creditCard.id,
    }));

    final response = await request.close();
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return _parseOrder(data);
  }

  Order _parseOrder(Map<String, dynamic> data) {
    return Order(
      id: data['id'],
      items: (data['items'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, double.parse(value.toString()))),
      status: OrderStatus.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toLowerCase() ==
            data['status'].toLowerCase(),
      ),
      addressId: data['addressId'],
      creditCardId: data['creditCardId'],
      total: data['subtotal'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}
