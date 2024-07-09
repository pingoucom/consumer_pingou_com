import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';
import 'package:flutter/material.dart';

class PlanProvider extends ChangeNotifier {
  final PlanRepository _planRepository;

  PlanProvider(this._planRepository);

  List<Plan> _availablePlans = [];
  bool _isLoadingAvailablePlans = false;
  bool _hasLoadedAvailablePlans = false;

  List<Plan> get availablePlans => _availablePlans;
  bool get isLoadingAvailablePlans => _isLoadingAvailablePlans;
  bool get hasLoadedAvailablePlans => _hasLoadedAvailablePlans;

  void loadInitialAvailablePlans() async {
    if (_hasLoadedAvailablePlans) return;

    _isLoadingAvailablePlans = true;
    notifyListeners();

    try {
      List<Plan> plans = await _planRepository.getAvaiablePlans();
      _availablePlans = plans;
      _hasLoadedAvailablePlans = true;
      print("Plans loaded successfully: ${plans.length} plans found.");
    } catch (e) {
      print("Error loading plans: $e");
    } finally {
      _isLoadingAvailablePlans = false;
      notifyListeners();
    }
  }

  void refreshAvailablePlans() async {
    if (_isLoadingAvailablePlans) return;

    _isLoadingAvailablePlans = true;
    notifyListeners();

    try {
      List<Plan> plans = await _planRepository.getAvaiablePlans();
      _availablePlans = plans;
      print("Plans refreshed successfully: ${plans.length} plans found.");
    } catch (e) {
      print("Error refreshing plans: $e");
    } finally {
      _isLoadingAvailablePlans = false;
      notifyListeners();
    }
  }

  //A ideia aqui seria pegar o id do usuario e fazer a pesquisa, existe ja
  //a requisição para isso, so n sei como vai funcionar a passagem do userID.
  String _currentPlan = 'Plano 1';

  Plan get subscription {
    return _availablePlans.firstWhere(
      (plan) => plan.title == _currentPlan,
      orElse: () => Plan(
        title: 'Plano Padrão',
        features: ['Descrição do Plano Padrão'],
        id: '5',
        monthlyPrice: 0,
        semiAnnualPrice: 0,
      ),
    );
  }
}
