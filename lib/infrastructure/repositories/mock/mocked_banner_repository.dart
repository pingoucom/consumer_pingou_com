import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';

class MockedBannerRepository implements BannerRepository {
  final Random _random = Random();

  final List<Banner_class> _banners = [
    Banner_class(
      id: '1',
      image: 'assets/img/banner2.png',
      category: 'Para Você',
      deeplink: '/store?tagId=1',
    ),
    Banner_class(
      id: '2',
      image: 'assets/img/banner3.jpeg',
      category: 'Para Você',
      deeplink: '/store?tagId=2',
    ),
    Banner_class(
      id: '3',
      image: 'assets/img/banner6.jpeg',
      category: 'Novidades',
      deeplink: '/store?tagId=3',
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
}
