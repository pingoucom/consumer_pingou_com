import 'package:consumer_pingou_com/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<User?> signIn(String email, String password);

  Future<User?> signUp(String name, String email, String password,
      String phoneNumber, DateTime birthDate);
}
