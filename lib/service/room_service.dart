import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RoomService {
  final String baseUrl = "http://localhost:8080";

  Future<List<dynamic>> getAllRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/rooms/all-rooms'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  Future<List<dynamic>> getAvailableRooms(String checkIn, String checkOut, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/rooms/available-rooms?checkInDate=$checkIn&checkOutDate=$checkOut&roomType=$type'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load available rooms');
    }
  }
}
