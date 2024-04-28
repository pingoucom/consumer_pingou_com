import 'package:consumer_pingou_com/domain/enums/plan_flag.dart';

class Plan {
  final String id;
  final String title;
  final double monthlyPrice;
  final double semiAnnualPrice;
  final List<String> features;
  final PlanFlag? flag;

  Plan({
    required this.id,
    required this.title,
    required this.monthlyPrice,
    required this.semiAnnualPrice,
    required this.features,
    this.flag,
  });
}
