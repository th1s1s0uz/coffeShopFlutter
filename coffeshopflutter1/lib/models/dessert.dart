class Desserts {
  final String? id;
  final String? name;
  final String? description;
  final String? imagePath;
  final double? price;
  int quantity;

  Desserts({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    this.price,
    this.quantity = 0,
  });
}