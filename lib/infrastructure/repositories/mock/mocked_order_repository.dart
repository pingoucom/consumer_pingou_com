import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/enums/order_status.dart';
import 'package:consumer_pingou_com/domain/repositories/order_repository.dart';

class MockedOrderRepository implements OrderRepository {
  final Random _random = Random();

  final List<Order> _orders = [
    Order(
      id: '1',
      status: OrderStatus.delivered,
      items: {
        '20': 2,
      },
      addressId: '1',
      creditCardId: '2',
      total: 30,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<Order> add(Map<Product, double> items, Address address,
      CreditCard creditCard) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);
    Order order = Order(
      id: (_random.nextInt(1000) + 1000).toString(),
      status: OrderStatus.created,
      addressId: address.id,
      creditCardId: creditCard.id,
      items: items.map((p, q) => MapEntry(p.id, q)),
      total:
          items.keys.map((p) => p.price * items[p]!).reduce((a, b) => a + b) +
              15.0,
      createdAt: DateTime.now(),
    );

    _orders.add(order);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => order,
    );
  }

  @override
  Future<List<Order>> get() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _orders,
    );
  }

  @override
  Future<Order?> find(String orderId) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _orders.where((order) => order.id == orderId).firstOrNull,
    );
  }
}
