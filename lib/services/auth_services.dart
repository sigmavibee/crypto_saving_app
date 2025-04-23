import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract token and user ID from the response
        final token = data['token'];
        final user = data['user'];
        final id = user?['id'];

        if (token == null || id == null) {
          print('Missing token or user ID in the response');
          return false;
        }

        await _saveToken(token);
        await _saveid(id.toString());
        return true;
      } else {
        print('Login failed. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  Future<void> _saveid(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    print('Saved id: $id'); // Debug print
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

  Future<Map<String, dynamic>?> getUser(int id) async {
    try {
      // Retrieve the token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('No token found');
        return null;
      }

      // Make the API call to fetch user data
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/users/$id'), // Pass the id in the URL
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch user data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error in getUser: $e');
      return null;
    }
  }
}
