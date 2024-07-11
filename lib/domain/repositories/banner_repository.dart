import 'package:consumer_pingou_com/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<List<Banner_class>> getAvailableBanner();
}
