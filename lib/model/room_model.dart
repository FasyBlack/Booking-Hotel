class Room {
  final int id;
  final String roomType;
  final String roomPrice;
  final String? photo;

  Room({
    required this.id,
    required this.roomType,
    required this.roomPrice,
    this.photo,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? 0,
      roomType: json['roomType'] ?? 'Tipe Tidak Diketahui',
      roomPrice: json['roomPrice']?.toString() ?? '0',
      photo: json['photo'],
    );
  }
}
