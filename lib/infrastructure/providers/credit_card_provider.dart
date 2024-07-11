import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';
import 'package:flutter/material.dart';

class CreditCardProvider extends ChangeNotifier {
  final CreditCardRepository _creditCardRepository;

  CreditCardProvider(this._creditCardRepository);

  final List<CreditCard> _userCreditCards = [];
  bool _hasLoadedInitialData = false;
  String? _selectedCreditCardId;

  List<CreditCard> get userCreditCards => List.unmodifiable(_userCreditCards);
  bool get hasLoadedInitialData => _hasLoadedInitialData;
  CreditCard get selectedCreditCard => _userCreditCards
      .firstWhere((creditCard) => creditCard.id == _selectedCreditCardId);
  String? get selectedCreditCardId => _selectedCreditCardId;

  void loadInitialData() async {
    if (_hasLoadedInitialData) return;

    final creditCards = await _creditCardRepository.getAll();
    _userCreditCards.addAll(creditCards);

    if (_userCreditCards.isNotEmpty) {
      _selectedCreditCardId = _userCreditCards.first.id;
    }

    _hasLoadedInitialData = true;
    notifyListeners();
  }

  void setSelectedCreditCard(CreditCard creditCard) {
    if (creditCard.id == _selectedCreditCardId) {
      return;
    }

    _selectedCreditCardId = creditCard.id;
    notifyListeners();
  }

  Future<void> deleteCreditCard(CreditCard creditCard) async {
    if (_userCreditCards.length == 1) {
      return;
    }

    await _creditCardRepository.delete(creditCard.id);

    final oldIndex = _userCreditCards.indexOf(creditCard);
    _userCreditCards.remove(creditCard);

    if (_selectedCreditCardId == creditCard.id && oldIndex > 0) {
      _selectedCreditCardId = _userCreditCards[oldIndex - 1].id;
    } else if (_selectedCreditCardId == creditCard.id && oldIndex == 0) {
      _selectedCreditCardId = _userCreditCards[oldIndex].id;
    }

    notifyListeners();
  }

  Future<void> add(CreditCardInput input) async {
    final storedCreditCard = await _creditCardRepository.add(input);
    _userCreditCards.add(storedCreditCard);
    _selectedCreditCardId = storedCreditCard.id;
    notifyListeners();
  }
}
