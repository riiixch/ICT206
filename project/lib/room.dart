class Room {
  final String name;
  final String price;

  Room({required this.name, required this.price});

  // Factory method เพื่อแปลง JSON เป็น Room
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      price: json['price'],
    );
  }
}
