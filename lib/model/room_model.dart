class Room {
  final int id;
  final String? roomType;
  final String? roomPrice;
  final String? photo;

  Room({
    required this.id,
    this.roomType,
    this.roomPrice,
    this.photo,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomType: json['roomType'],
      // Convert int price to String safely
      roomPrice: json['roomPrice']?.toString(),
      photo: json['photo'],
    );
  }
}
