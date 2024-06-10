import 'package:consumer_pingou_com/domain/entities/plan.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final Plan plan;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.plan});
}
