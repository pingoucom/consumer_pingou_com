import 'package:consumer_pingou_com/domain/entities/subscriptionPlan.dart';
import 'package:flutter/material.dart';

class SubscriptionProvider with ChangeNotifier {
  List<SubscriptionPlan> _plans = [
    SubscriptionPlan(
        name: 'Basic',
        benefits: 'Basic features',
        price: 9.99,
        startDate: '01/01/2022',
        is_active: false),
    SubscriptionPlan(
        name: 'Premium',
        benefits: 'Premium features',
        price: 19.99,
        startDate: '01/01/2022',
        is_active: true),
    SubscriptionPlan(
        name: 'Family',
        benefits: 'Family sharing',
        price: 29.99,
        startDate: '01/01/2022',
        is_active: false),
  ];

  String _currentPlan = 'Premium';

  List<SubscriptionPlan> get plans => _plans;
  String get currentPlan => _currentPlan;

  void subscribe(String plan) {
    _currentPlan = plan;
    notifyListeners();
  }
}
