import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';

abstract class BannerRepository {
  Future<List<Banner_class>> getAvailableBanner();

 

  Future<List<ProductTag>> getFeaturedBannerTags();
}