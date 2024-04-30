import 'package:consumer_pingou_com/domain/entities/cachaca.dart';
import 'package:consumer_pingou_com/domain/repositories/cachaca_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  final CachacaRepository _cachacaRepository;

  HomeScreenProvider(this._cachacaRepository);
  List<Cachaca> _availableCachacas = [];
  bool _isLoadingAvailableCachacas = false;
  bool _hasLoadedAvailableCachacas = false;

  List<Cachaca> get availableCachacas => _availableCachacas;
  bool get isLoadingAvailableCachacas => _isLoadingAvailableCachacas;
  bool get hasLoadedAvailableCachacas => _hasLoadedAvailableCachacas;

  void loadAvailableCachacas() async {
    if (_hasLoadedAvailableCachacas) return;

    _isLoadingAvailableCachacas = true;
    notifyListeners();

    List<Cachaca> cachacas = await _cachacaRepository.getAvailableCachacas();
    _availableCachacas = cachacas;
    _hasLoadedAvailableCachacas = true;
    _isLoadingAvailableCachacas = false;
    notifyListeners();
  }

  void refreshAvailableCachacas() async {
    if (_isLoadingAvailableCachacas) return;

    _isLoadingAvailableCachacas = true;
    notifyListeners();

    List<Cachaca> cachacas = await _cachacaRepository.getAvailableCachacas();
    _availableCachacas = cachacas;
    _isLoadingAvailableCachacas = false;
    notifyListeners();
  }

  List<String> get availableCategories {
    return _availableCachacas
        .map((cachaca) => cachaca.category)
        .toSet()
        .toList();
  }

  Map<String, List<Cachaca>> get groupedCachacasByCategory {
    Map<String, List<Cachaca>> groupedCachacas = {};
    for (var cachaca in _availableCachacas) {
      if (groupedCachacas.containsKey(cachaca.category)) {
        groupedCachacas[cachaca.category]!.add(cachaca);
      } else {
        groupedCachacas[cachaca.category] = [cachaca];
      }
    }
    return groupedCachacas;
  }

  List<String> getCategoryNames() {
    return _availableCachacas
        .map((cachaca) => cachaca.category)
        .toSet()
        .toList();
  }

  List<Cachaca> getCachacasByCategory(String category) {
    return _availableCachacas
        .where((cachaca) => cachaca.category == category)
        .toList();
  }
}
