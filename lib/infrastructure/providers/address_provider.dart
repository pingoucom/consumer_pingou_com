import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  final AddressRepository _addressRepository;

  AddressProvider(this._addressRepository);

  final List<Address> _userAddresses = [
    Address(
      id: '1',
      street: 'Rua dos Bobos',
      number: '21',
      neighborhood: 'Bairro Feliz',
      city: 'Cidade Alegre',
      state: AddressState.rn,
      postalCode: '12345-678',
    ),
    Address(
      id: '2',
      street: 'Rua do John Doe',
      number: '42',
      neighborhood: 'Bairro Triste',
      city: 'Cidade Triste',
      state: AddressState.rs,
      postalCode: '98765-432',
    ),
  ];

  String _selectedAddressId = '1';

  List<Address> get userAddresses => List.unmodifiable(_userAddresses);
  Address get selectedAddress =>
      _userAddresses.firstWhere((address) => address.id == _selectedAddressId);
  String get selectedAddressId => _selectedAddressId;

  void setSelectedAddress(Address address) {
    if (address.id == _selectedAddressId) {
      return;
    }

    _selectedAddressId = address.id;
    notifyListeners();
  }

  void deleteAddress(Address address) {
    if (_userAddresses.length == 1) {
      return;
    }

    final oldIndex = _userAddresses.indexOf(address);
    _userAddresses.remove(address);

    if (_selectedAddressId == address.id && oldIndex > 0) {
      _selectedAddressId = _userAddresses[oldIndex - 1].id;
    } else if (_selectedAddressId == address.id && oldIndex == 0) {
      _selectedAddressId = _userAddresses[oldIndex].id;
    }

    notifyListeners();
  }

  Future<PostalCodeQueryResult?> queryPostalCode(String postalCode) {
    return _addressRepository.queryPostalCode(postalCode);
  }

  Future<void> add(AddressInput input) async {
    final storedAddress = await _addressRepository.add(input);
    _userAddresses.add(storedAddress);
    _selectedAddressId = storedAddress.id;
    notifyListeners();
  }

  Future<void> update(Address address, AddressInput input) async {
    final updatedAddress = await _addressRepository.update(address.id, input);
    _userAddresses[_userAddresses.indexOf(address)] = updatedAddress;
    _selectedAddressId = updatedAddress.id;
    notifyListeners();
  }
}
