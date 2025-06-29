import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  final String baseUrl = "http://localhost:8080";

  Future<List<dynamic>> getUserBookings(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/bookings/user/$email/bookings'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<String> bookRoom(int roomId, Map<String, dynamic> bookingData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/bookings/room/$roomId/booking'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(bookingData),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to book room');
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrl/bookings/booking/$bookingId/delete'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to cancel booking');
    }
  }
}
