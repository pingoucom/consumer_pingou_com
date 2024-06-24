import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/enums/plan_flag.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';

class RestPlanRepository implements PlanRepository {
  final baseUri = 'http://10.0.2.2:8080/pingou';

  final HttpClient _httpClient = HttpClient();

  @override
  Future<List<Plan>> getAvaiablePlans() async {
    final uri = Uri.parse('$baseUri/plans');

    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) return [];

    final responseJson = jsonDecode(responseBody);

    return (responseJson as List).map((planJson) {
      PlanFlag? flag;

      if (planJson['nome'].toString().contains('Premium')) {
        flag = PlanFlag.premium;
      } else if (planJson['nome'].toString().contains('Básico')) {
        flag = PlanFlag.recommended;
      } else if (planJson['nome'].toString().contains('Universitário')) {
        flag = PlanFlag.cheapest;
      }

      return Plan(
        id: planJson['plano_id'].toString(),
        title: planJson['nome'],
        monthlyPrice: planJson['preco'],
        semiAnnualPrice: planJson['preco'] * 5.5,
        flag: flag,
        features: [],
      );
    }).toList();
  }
}
