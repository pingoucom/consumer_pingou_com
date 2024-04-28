import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/enums/plan_flag.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';

class MockedPlanRepository implements PlanRepository {
  final Random _random = Random();

  @override
  Future<List<Plan>> getAvaiablePlans() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => [
        Plan(
          id: '1',
          title: 'Plano 1',
          monthlyPrice: 99.90,
          semiAnnualPrice: 499.90,
          flag: PlanFlag.recommended,
          features: [
            '2 garrafas entregues todo mês na sua casa!',
            'Acesso a eventos exclusivos',
            'Descontos em produtos parceiros',
          ],
        ),
        Plan(
          id: '2',
          title: 'Plano 2',
          monthlyPrice: 99.90,
          semiAnnualPrice: 499.90,
          flag: PlanFlag.cheapest,
          features: [
            '2 garrafas entregues todo mês na sua casa!',
            'Acesso a eventos exclusivos',
            'Descontos em produtos parceiros',
          ],
        ),
        Plan(
          id: '3',
          title: 'Plano 3',
          monthlyPrice: 99.90,
          semiAnnualPrice: 499.90,
          flag: PlanFlag.premium,
          features: [
            '2 garrafas entregues todo mês na sua casa!',
            'Acesso a eventos exclusivos',
            'Descontos em produtos parceiros',
          ],
        ),
      ],
    );
  }
}
