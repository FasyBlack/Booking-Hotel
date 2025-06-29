import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = "http://localhost:8080";

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/users/$email'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> deleteUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrl/users/delete/$email'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
  Future<String> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final email = prefs.getString('email');

  if (email == null || token == null) {
    return "User";
  }

  try {
    final userData = await getUserByEmail(email);
    final firstName = userData['firstName'] ?? '';
    final lastName = userData['lastName'] ?? '';
    return '$firstName $lastName'.trim();
  } catch (e) {
    return "User";
  }
}

}