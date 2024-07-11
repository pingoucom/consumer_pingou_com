import 'package:consumer_pingou_com/domain/enums/order_status.dart';

class Order {
  final String id;
  final OrderStatus status;
  final Map<String, double> items;
  final String addressId;
  final String creditCardId;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.addressId,
    required this.creditCardId,
    required this.total,
    required this.createdAt,
  });
}
