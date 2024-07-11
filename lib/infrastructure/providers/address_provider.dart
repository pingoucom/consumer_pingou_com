import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  final AddressRepository _addressRepository;

  AddressProvider(this._addressRepository);

  final List<Address> _userAddresses = [];
  bool _hasLoadedInitialData = false;
  String? _selectedAddressId;

  List<Address> get userAddresses => List.unmodifiable(_userAddresses);
  bool get hasLoadedInitialData => _hasLoadedInitialData;
  Address get selectedAddress =>
      _userAddresses.firstWhere((address) => address.id == _selectedAddressId);
  String? get selectedAddressId => _selectedAddressId;

  void loadInitialData() async {
    if (_hasLoadedInitialData) return;

    final addresses = await _addressRepository.getUserAddresses();
    _userAddresses.addAll(addresses);

    if (_userAddresses.isNotEmpty) {
      _selectedAddressId = _userAddresses.first.id;
    }

    _hasLoadedInitialData = true;
    notifyListeners();
  }

  void setSelectedAddress(Address address) {
    if (address.id == _selectedAddressId) {
      return;
    }

    _selectedAddressId = address.id;
    notifyListeners();
  }

  Future<void> deleteAddress(Address address) async {
    if (_userAddresses.length == 1) {
      return;
    }

    await _addressRepository.delete(address.id);

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
