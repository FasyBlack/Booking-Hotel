import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://192.168.1.11:8080/auth"; // Ganti sesuai IP lokal atau pakai 10.0.2.2 di emulator

  /// Login dan simpan token ke SharedPreferences jika berhasil
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

        // Simpan token JWT
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return body; // id, email, token, roles, dll
      } else {
        throw Exception('Login gagal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat login: $e');
    }
  }

  Future<String> register(String firstName, String lastName, String email, String password) async {
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


  /// Ambil token JWT dari local storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Hapus token saat logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
