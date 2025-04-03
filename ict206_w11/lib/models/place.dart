class Place {
  final int id;
  final String name;
  final String description;
  final String image;
  final String location;
  final String createdAt;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    required this.createdAt,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      location: json['location'],
      createdAt: json['created_at'],
    );
  }
}