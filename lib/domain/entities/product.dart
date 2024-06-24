class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final double price;
  final int stock;
  final List<String> tagIds;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.image = '',
    required this.price,
    required this.stock,
    this.tagIds = const [],
  });
}
