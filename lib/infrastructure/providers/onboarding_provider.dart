import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final PlanRepository _planRepository;

  OnboardingProvider(this._planRepository);

  List<Plan> _availablePlans = [];
  bool _isLoadingAvailablePlans = false;
  bool _hasLoadedAvailablePlans = false;
  bool _showingMonthlyPrice = true;
  Plan? _selectedPlan;
  CreditCard? _creditCard;
  Address? _address;

  List<Plan> get availablePlans => _availablePlans;
  bool get isLoadingAvailablePlans => _isLoadingAvailablePlans;
  bool get hasLoadedAvailablePlans => _hasLoadedAvailablePlans;
  bool get showingMonthlyPrice => _showingMonthlyPrice;
  Plan? get selectedPlan => _selectedPlan;
  CreditCard? get creditCard => _creditCard;
  Address? get address => _address;

  void loadInitialAvailablePlans() async {
    if (_hasLoadedAvailablePlans) return;

    _isLoadingAvailablePlans = true;
    notifyListeners();

    List<Plan> plans = await _planRepository.getAvaiablePlans();
    _availablePlans = plans;
    _hasLoadedAvailablePlans = true;
    _isLoadingAvailablePlans = false;
    notifyListeners();
  }

  void refreshAvailablePlans() async {
    if (_isLoadingAvailablePlans) return;

    _isLoadingAvailablePlans = true;
    notifyListeners();

    List<Plan> plans = await _planRepository.getAvaiablePlans();
    _availablePlans = plans;
    _isLoadingAvailablePlans = false;
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
