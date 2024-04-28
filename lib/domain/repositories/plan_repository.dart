import 'package:consumer_pingou_com/domain/entities/plan.dart';

abstract class PlanRepository {
  Future<List<Plan>> getAvaiablePlans();
}
