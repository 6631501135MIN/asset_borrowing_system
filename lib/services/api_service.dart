import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Updated to match your server's IP address from .env file
  // Your server is running on HOST=192.168.1.173, PORT=3000
  static const String baseUrl = 'http://192.168.1.173:3000/api';

  // Alternative configurations (comment/uncomment as needed):
  // For Android emulator: use 10.0.2.2
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  
  // For iOS simulator: can use localhost or the IP
  // static const String baseUrl = 'http://localhost:3000/api';
  // static const String baseUrl = 'http://192.168.1.173:3000/api';

  /// Register a new student user
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
    String? phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'username': username,
          'ph_num': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        // Error from server
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      // Network error or other exception
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  /// Login user
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
