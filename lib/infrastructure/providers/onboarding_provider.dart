import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/enums/plan_flag.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  List<Plan> _availablePlans = [
    Plan(
      id: '1',
      title: 'Plano 1',
      monthlyPrice: 99.90,
      semiAnnualPrice: 499.90,
      flag: PlanFlag.recommended,
      features: [
        '2 garrafas entregues todo mês na sua casa!',
        'Acesso a eventos exclusivos',
        'Descontos em produtos parceiros',
      ],
    ),
    Plan(
      id: '2',
      title: 'Plano 2',
      monthlyPrice: 99.90,
      semiAnnualPrice: 499.90,
      flag: PlanFlag.cheapest,
      features: [
        '2 garrafas entregues todo mês na sua casa!',
        'Acesso a eventos exclusivos',
        'Descontos em produtos parceiros',
      ],
    ),
    Plan(
      id: '3',
      title: 'Plano 3',
      monthlyPrice: 99.90,
      semiAnnualPrice: 499.90,
      flag: PlanFlag.premium,
      features: [
        '2 garrafas entregues todo mês na sua casa!',
        'Acesso a eventos exclusivos',
        'Descontos em produtos parceiros',
      ],
    ),
  ];
  bool _hasLoadedAvailablePlans = false;
  bool _showingMonthlyPrice = true;
  Plan? _selectedPlan;
  CreditCard? _creditCard;
  Address? _address;

  List<Plan> get availablePlans => _availablePlans;
  bool get hasLoadedAvailablePlans => _hasLoadedAvailablePlans;
  bool get showingMonthlyPrice => _showingMonthlyPrice;
  Plan? get selectedPlan => _selectedPlan;
  CreditCard? get creditCard => _creditCard;
  Address? get address => _address;

  void setAvailablePlans(List<Plan> plans) {
    _availablePlans = plans;
    _hasLoadedAvailablePlans = true;
    notifyListeners();
  }

  void setSelectedPlan(Plan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  void clearSelectedPlan() {
    _selectedPlan = null;
    notifyListeners();
  }

  void setCreditCard(CreditCard creditCard) {
    _creditCard = creditCard;
    notifyListeners();
  }

  void clearCreditCard() {
    _creditCard = null;
    notifyListeners();
  }

  void togglePriceView() {
    _showingMonthlyPrice = !_showingMonthlyPrice;
    notifyListeners();
  }

  void setAddress(Address address) {
    _address = address;
    notifyListeners();
  }
}
