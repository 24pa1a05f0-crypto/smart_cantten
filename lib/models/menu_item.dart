class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.isAvailable,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final double rating;
  final bool isAvailable;
  final String imageUrl;
}
