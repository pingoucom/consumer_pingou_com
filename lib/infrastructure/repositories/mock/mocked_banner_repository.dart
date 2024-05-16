import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';


class MockedBannerRepository implements BannerRepository {
  final Random _random = Random();

  final List<Banner_class> _banners = [
    Banner_class(
      id: '1',
      name: 'Banner 1',
      description: 'Promoçao de etc 1',
      image: 'assets/img/sagatiba.jpeg',
      category: 'Recomendados',
    ),
      Banner_class(
      id: '2',
      name: 'Banner 2',
      description: 'Promoçao de etc 2',
      image: 'assets/img/sagatiba.jpeg',
      category: 'Recomendados',
    ),
      Banner_class(
      id: '3',
      name: 'Banner 3',
      description: 'Promoçao de etc 3',
      image: 'assets/img/sagatiba.jpeg',
      category: 'Recomendados',
    ),
       Banner_class(
      id: '4',
      name: 'Banner 4',
      description: 'Promoçao de etc 4',
      image: 'assets/img/sagatiba.jpeg',
      category: 'Recomendados',
    ),
  ];

  final List<ProductTag> _featuredProductTags = [
    ProductTag(
      id: '1',
      slug: 'recommended',
    ),
    ProductTag(
      id: '2',
      slug: 'new',
    ),
    ProductTag(
      id: '3',
      slug: 'regional',
    ),
    ProductTag(
      id: '4',
      slug: 'yellow',
    ),
  ];

  @override
  Future<List<Banner_class>> getAvailableBanner() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _banners,
    );
  }

 

  @override
  Future<List<ProductTag>> getFeaturedBannerTags() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _featuredProductTags,
    );
  }
}
