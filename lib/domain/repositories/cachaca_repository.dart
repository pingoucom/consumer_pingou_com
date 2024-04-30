import 'package:consumer_pingou_com/domain/entities/cachaca.dart';

abstract class CachacaRepository {
  Future<List<Cachaca>> getAvailableCachacas();
}
