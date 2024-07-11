class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final double price;
  final List<String> tagIds;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    this.tagIds = const [],
  });
}
