import 'package:consumer_pingou_com/domain/enums/order_status.dart';
import 'package:flutter/material.dart';

class OrderStatusIconFactory {
  static IconData _makeReceivedIcon() {
    return Icons.flag;
  }

  static IconData _makeConfirmedIcon() {
    return Icons.inventory_rounded;
  }

  static IconData _makePreparingIcon() {
    return Icons.autorenew;
  }

  static IconData _makeReadyIcon() {
    return Icons.checklist;
  }

  static IconData _makeOnTheWayIcon() {
    return Icons.local_shipping;
  }

  static IconData _makeDeliveredIcon() {
    return Icons.check_circle;
  }

  static IconData _makeCanceledIcon() {
    return Icons.cancel;
  }

  static IconData _makeErrorIcon() {
    return Icons.error;
  }

  static IconData make(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.received:
        return _makeReceivedIcon();
      case OrderStatus.confirmed:
        return _makeConfirmedIcon();
      case OrderStatus.preparing:
        return _makePreparingIcon();
      case OrderStatus.ready:
        return _makeReadyIcon();
      case OrderStatus.onTheWay:
        return _makeOnTheWayIcon();
      case OrderStatus.delivered:
        return _makeDeliveredIcon();
      case OrderStatus.canceled:
        return _makeCanceledIcon();
      default:
        return _makeErrorIcon();
    }
  }
}
