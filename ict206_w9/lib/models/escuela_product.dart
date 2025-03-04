class EscuelaProduct {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final List<String> images;

  EscuelaProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory EscuelaProduct.fromJson(Map<String, dynamic> json) {
    return EscuelaProduct(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category']['name'],
      images: List<String>.from(json['images']),
    );
  }
}