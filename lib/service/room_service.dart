// room_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/room_model.dart';

class RoomService {
  final String baseUrl = 'http://10.219.45.207:8080'; // Sesuaikan dengan IP backend

  /// Ambil semua kamar dari Spring Boot
  Future<List<Room>> getRooms() async {
    final response = await http.get(Uri.parse('$baseUrl/rooms/all-rooms'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data kamar. Status: \${response.statusCode}');
    }
  }

  /// Tambah kamar (admin)
  Future<void> addRoom({
    required String roomType,
    required String price,
    required File imageFile,
    required String token,
  }) async {
    final uri = Uri.parse('$baseUrl/rooms/add/new-room');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['roomType'] = roomType
      ..fields['roomPrice'] = price
      ..files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan kamar. Status: \${response.statusCode}');
    }
  }
}
