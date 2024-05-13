import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/enums/card_brand.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';
import 'package:flutter/material.dart';

class CreditCardProvider extends ChangeNotifier {
  final CreditCardRepository _creditCardRepository;

  CreditCardProvider(this._creditCardRepository);

  final List<CreditCard> _userCreditCards = [
    CreditCard(
      id: '1',
      brand: CardBrand.elo,
      lastFourDigits: '4321',
      holderFirstName: 'Lorem',
    ),
    CreditCard(
      id: '2',
      brand: CardBrand.mastercard,
      lastFourDigits: '1234',
      holderFirstName: 'John',
    ),
    CreditCard(
      id: '3',
      brand: CardBrand.visa,
      lastFourDigits: '5678',
      holderFirstName: 'Jane',
    ),
  ];

  String _selectedCreditCardId = '1';

  List<CreditCard> get userCreditCards => List.unmodifiable(_userCreditCards);
  CreditCard get selectedCreditCard => _userCreditCards
      .firstWhere((creditCard) => creditCard.id == _selectedCreditCardId);
  String get selectedCreditCardId => _selectedCreditCardId;

  void setSelectedCreditCard(CreditCard creditCard) {
    if (creditCard.id == _selectedCreditCardId) {
      return;
    }

    _selectedCreditCardId = creditCard.id;
    notifyListeners();
  }

  void deleteCreditCard(CreditCard creditCard) {
    if (_userCreditCards.length == 1) {
      return;
    }

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
