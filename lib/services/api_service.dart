import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Updated to match your server's IP address
  static const String baseUrl = 'http://192.168.1.185:3000/api';

  // Alternative configurations (comment/uncomment as needed):
  // For Android emulator: use 10.0.2.2
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  
  // For iOS simulator: can use localhost or the IP
  // static const String baseUrl = 'http://localhost:3000/api';

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
  /// Supports login with email, username, or uid
  static Future<Map<String, dynamic>> login({
    String? email,
    String? username,
    String? uid,
    required String password,
  }) async {
    try {
      // Build request body - send whichever credential is provided
      final Map<String, dynamic> requestBody = {'password': password};
      
      if (email != null && email.isNotEmpty) {
        requestBody['email'] = email;
      } else if (username != null && username.isNotEmpty) {
        requestBody['username'] = username;
      } else if (uid != null && uid.isNotEmpty) {
        requestBody['uid'] = uid;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
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

  /// Fetch student categories
  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/student/categories'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load categories: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  /// Fetch all available assets
  static Future<List<Map<String, dynamic>>> fetchAssets() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/student/assets'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load assets: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  /// Fetch assets by category ID
  static Future<List<Map<String, dynamic>>> fetchAssetsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/student/assets/category/$categoryId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load assets for category: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  /// Submit a borrow request
  static Future<Map<String, dynamic>> submitBorrowRequest({
    required int borrowerId,
    required int assetId,
    required String borrowDate,
    required String returnDate,
  }) async {
    try {
      final requestBody = {
        'borrower_id': borrowerId,
        'asset_id': assetId,
        'borrow_date': borrowDate,
        'return_date': returnDate,
      };
      
      print('🔄 Submitting borrow request:');
      print('   URL: $baseUrl/student/borrow');
      print('   Body: $requestBody');
      
      final response = await http.post(
        Uri.parse('$baseUrl/student/borrow'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      print('❌ Error submitting borrow request: $e');
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  /// Fetch student's borrow requests
  static Future<List<Map<String, dynamic>>> fetchStudentRequests(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/student/requests/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load requests: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
