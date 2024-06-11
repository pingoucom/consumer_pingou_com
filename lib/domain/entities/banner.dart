import 'package:consumer_pingou_com/domain/entities/product_tag.dart';

class Banner_class {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final ProductTag tag;

  Banner_class({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.tag,
  });
}
