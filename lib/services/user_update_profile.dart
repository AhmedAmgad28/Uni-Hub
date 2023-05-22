import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<void> updateProfile(String name, String phone, String photo) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/users/updateMe');
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
    throw Exception('Failed to update user data');
  }
}
