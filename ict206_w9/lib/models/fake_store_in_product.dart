class FakeStoreInProduct {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String category;
  final int? discount; // เปลี่ยนเป็น nullable int
  final bool? popular;  // เปลี่ยนเป็น nullable bool
  final bool? onSale;   // เปลี่ยนเป็น nullable bool

  FakeStoreInProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.category,
    this.discount,
    this.popular,
    this.onSale,
  });

  factory FakeStoreInProduct.fromJson(Map<String, dynamic> json) {

    print(json['image']);

    return FakeStoreInProduct(
      id: json['id'],
      title: json['title'] ?? '', // หาก null ให้ใช้ String ว่าง
      image: json['image'] ?? '', // หาก null ให้ใช้ String ว่าง
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // หาก null ให้ใช้ 0.0
      description: json['description'] ?? '', // หาก null ให้ใช้ String ว่าง
      brand: json['brand'] ?? '', // หาก null ให้ใช้ String ว่าง
      model: json['model'] ?? '', // หาก null ให้ใช้ String ว่าง
      color: json['color'] ?? '', // หาก null ให้ใช้ String ว่าง
      category: json['category'] ?? '', // หาก null ให้ใช้ String ว่าง
      discount: json['discount'] as int?, // รับค่า int หรือ null
      popular: json['popular'] as bool?, // รับค่า bool หรือ null
      onSale: json['onSale'] as bool?, // รับค่า bool หรือ null
    );
  }
}