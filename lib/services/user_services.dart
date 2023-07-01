import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

//get user info
Future<Map<String, dynamic>> getMe() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/me');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get user data');
  }
}



//i used it to get user ads
Future<Map<String, dynamic>> getUserData() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  const url = 'https://unihub.azurewebsites.net/api/v1/users/me';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['data']['user'];
  } else {
    throw Exception('Failed to load user data');
  }
}



//update user info
Future<void> updateProfile(String name, String phone, String photo) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/updateMe');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'name': name,
    'phone': phone,
    'photo': photo,
  });
  final response = await http.patch(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // Update successful
  } else {
    final message = jsonDecode(response.body)['message'] as String;
    throw Exception(message);
  }
}



//delete user 
Future<void> deleteMe() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/deleteMe');
  final response = await http.delete(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 204) {
  } else {
    throw json.decode(response.body)['message'];
  }
}