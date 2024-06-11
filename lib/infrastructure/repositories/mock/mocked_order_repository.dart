import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:consumer_pingou_com/domain/enums/order_status.dart';
import 'package:consumer_pingou_com/domain/repositories/order_repository.dart';

class MockedOrderRepository implements OrderRepository {
  final Random _random = Random();

  final List<Order> _orders = [
    Order(
      id: '1',
      status: OrderStatus.delivered,
      items: {
        Product(
          id: '20',
          name: 'In',
          description: 'At accumsan in',
          image: 'assets/img/products/sample_product_20.jpeg',
          category: '1',
          price: 25.25,
          stock: 2,
          tagIds: [
            '3',
            '4',
            '6',
          ],
        ): 2,
      },
      address: Address(
        id: '1',
        street: 'Rua dos Bobos',
        number: '21',
        neighborhood: 'Bairro Feliz',
        city: 'Cidade Alegre',
        state: AddressState.rn,
        postalCode: '12345-678',
      ),
      creditCard: CreditCard(
        id: '2',
        brand: CardBrand.mastercard,
        lastFourDigits: '1234',
        holderFirstName: 'John',
      ),
      serviceFee: 10,
      deliveryFee: 20,
      total: 30,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<Order> add(Map<Product, double> items, Address address,
      CreditCard creditCard) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => Order(
        id: (_random.nextInt(1000) + 1000).toString(),
        status: OrderStatus.received,
        address: address,
        creditCard: creditCard,
        items: items,
        deliveryFee: 10.0,
        serviceFee: 5.0,
        total:
            items.keys.map((p) => p.price * items[p]!).reduce((a, b) => a + b) +
                15.0,
        createdAt: DateTime.now(),
      ),
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
