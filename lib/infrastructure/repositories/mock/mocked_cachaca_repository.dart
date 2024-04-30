import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/cachaca.dart';
import 'package:consumer_pingou_com/domain/repositories/cachaca_repository.dart';

class MockedCachacaRepository implements CachacaRepository {
  final Random _random = Random();

  @override
  Future<List<Cachaca>> getAvailableCachacas() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);
    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => [
        Cachaca(
          id: '1',
          name: 'Cachaça 1',
          description: 'Descrição da cachaça 1',
          image: 'assets/img/sagatiba.jpeg',
          category: 'Recomendados',
          price: 25.25,
          stock: 2,
        ),
        Cachaca(
          id: '2',
          name: 'Cachaça 2',
          description: 'Descrição da cachaça 2',
          image: 'assets/img/matuta.jpeg',
          category: 'Recomendados',
          price: 50.25,
          stock: 2,
        ),
        Cachaca(
          id: '3',
          name: 'Cachaça 3',
          description: 'Descrição da cachaça 3',
          category: "Prata",
          image: 'assets/img/sagatiba.jpeg',
          price: 25.25,
          stock: 2,
        ),
        Cachaca(
          id: '4',
          name: 'Cachaça 4',
          description: 'Descrição da cachaça 4',
          category: "Dourada",
          image: 'assets/img/matuta.jpeg',
          price: 50.25,
          stock: 2,
        ),
      ],
    );
  }
}
