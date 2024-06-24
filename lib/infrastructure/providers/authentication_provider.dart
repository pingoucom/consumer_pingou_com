import 'package:consumer_pingou_com/domain/entities/user.dart';
import 'package:consumer_pingou_com/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationProvider(this._authenticationRepository);

  User? _user;

  User? get user => _user;

  Future<bool> signIn(String email, String password) async {
    _user = await _authenticationRepository.signIn(email, password);

    if (_user == null) {
      return false;
    }

    notifyListeners();

    return true;
  }

  Future<bool> signUp(String name, String email, String password,
      String phoneNumber, DateTime birthDate) async {
    _user = await _authenticationRepository.signUp(
      name,
      email,
      password,
      phoneNumber,
      birthDate,
    );

    if (_user == null) {
      return false;
    }

    notifyListeners();

    return true;
  }
}
