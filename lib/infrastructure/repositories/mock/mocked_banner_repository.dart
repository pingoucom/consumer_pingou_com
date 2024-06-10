import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';

class MockedBannerRepository implements BannerRepository {
  final Random _random = Random();

  final List<Banner_class> _banners = [
    Banner_class(
      id: '1',
      name: '51',
      description: 'Logo da 51',
      image: 'assets/img/banner2.png',
      category: 'Para Você',
    ),
    Banner_class(
      id: '2',
      name: 'Banner 2',
      description: 'Tem cabare essa noite',
      image: 'assets/img/banner3.jpeg',
      category: 'Para Você',
    ),
    Banner_class(
      id: '3',
      name: 'Banner 3',
      description: 'familia 51',
      image: 'assets/img/banner6.jpeg',
      category: 'Novidades',
    ),
  ];

  final List<ProductTag> _featuredProductTags = [
    ProductTag(
      id: '1',
      name: 'Recomendados',
      slug: 'recommended',
      iconId: 'new_releases',
    ),
    ProductTag(
      id: '2',
      name: 'Novos',
      slug: 'new',
      iconId: 'map',
    ),
    ProductTag(
      id: '3',
      name: 'Regionais',
      slug: 'regional',
      iconId: 'sunny',
    ),
    ProductTag(
      id: '4',
      name: 'Promoções',
      slug: 'yellow',
      iconId: 'local_offer',
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
