import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl =
      "http://192.168.1.10:8080/auth"; 

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'];
        final userEmail = body['email'];
        final roles = body['roles']; 
        final role = roles[
            0]; 

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', userEmail);
        await prefs.setString('role', role); 

        return body;
      } else {
        throw Exception('Login gagal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat login: $e');
    }
  }

  Future<String> register(
      String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register-user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Registrasi berhasil";
      } else {
        throw Exception('Register gagal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat registrasi: $e');
    }
  }

  
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 
}


  Future<String?> getRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}

}
