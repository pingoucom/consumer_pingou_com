import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  StoreProvider(this._productRepository);

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

  String? _selectedFeaturedProductTagId;
  bool _hasLoadedFeaturedProductTags = false;

  List<ProductTag> get featuredProductTags =>
      List.unmodifiable(_featuredProductTags);
  String? get selectedFeaturedProductTagId => _selectedFeaturedProductTagId;
  bool get hasLoadedFeaturedProductTags => _hasLoadedFeaturedProductTags;

  void setSelectedProductTag(ProductTag productTag) {
    if (productTag.id == _selectedFeaturedProductTagId) {
      return;
    }

    _selectedFeaturedProductTagId = productTag.id;
    notifyListeners();
  }

  void clearSelectedProductTag() {
    _selectedFeaturedProductTagId = null;
    notifyListeners();
  }

  void loadFeaturedProductTags() async {
    if (_hasLoadedFeaturedProductTags) return;

    _featuredProductTags.clear();
    _featuredProductTags
        .addAll(await _productRepository.getFeaturedProductTags());

    _hasLoadedFeaturedProductTags = true;
    notifyListeners();
  }
}
