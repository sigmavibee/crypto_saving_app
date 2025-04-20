import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      print('Token: $token'); // Added print statement for the token
      await _saveToken(token);
      return true;
    }
    return false;
  }

  Future<bool> register(
      String username, String email, String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'username': username,
          'password': password
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

//make if response.statusCode == 200
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return true;
      } else {
        // Log the error message from the response
        print('Registration failed. Status code: ${response.statusCode}');
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<Map<String, dynamic>?> getUser() async {
    String? token = await getToken();
    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
