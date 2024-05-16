import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeBannerScreenProvider extends ChangeNotifier {
  final BannerRepository _bannerRepository;

  HomeBannerScreenProvider(this._bannerRepository);
  List<Banner_class> _availableBanners = [];
  bool _isLoadingAvailableBanners = false;
  bool _hasLoadedAvailableBanners = false;

  List<Banner_class> get avaibleBanners => _availableBanners;
  bool get isLoadingAvailableProducts => _isLoadingAvailableBanners;
  bool get hasLoadedAvailableProducts => _hasLoadedAvailableBanners;

  void loadAvailableBanners() async {
    if (_hasLoadedAvailableBanners) return;

    _isLoadingAvailableBanners = true;
    notifyListeners();

    List<Banner_class> banners = await _bannerRepository.getAvailableBanner();
    _availableBanners = banners;
    _hasLoadedAvailableBanners = true;
    _isLoadingAvailableBanners = false;
    notifyListeners();
  }

  void refreshAvailableProducts() async {
    if (_isLoadingAvailableBanners) return;

    _isLoadingAvailableBanners = true;
    notifyListeners();

    List<Banner_class> banners = await _bannerRepository.getAvailableBanner();
    _availableBanners = banners;
    _isLoadingAvailableBanners = false;
    notifyListeners();
  }

  List<String> get availableCategories {
    return _availableBanners
        .map((banner_class) => banner_class.category)
        .toSet()
        .toList();
  }

  Map<String, List<Banner_class>> get groupedBannersByCategory {
    Map<String, List<Banner_class>> groupedBanners = {};
    for (var banner in _availableBanners) {
      if (groupedBanners.containsKey(banner.category)) {
        groupedBanners[banner.category]!.add(banner);
      } else {
        groupedBanners[banner.category] = [banner];
      }
    }
    return groupedBanners;
  }

  List<String> getCategoryNames() {
    return _availableBanners
        .map((banner) => banner.category)
        .toSet()
        .toList();
  }

  List<Banner_class> getBannersByCategory(String category) {
    return _availableBanners
        .where((banner) => banner.category == category)
        .toList();
  }
}
