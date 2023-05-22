import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<void> changePassword(String password, String newPassword, String newPasswordConfirm) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/users/updatePassword');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'password': password,
    'newPassword': newPassword,
    'newPasswordConfirm': newPasswordConfirm,
  });
  final response = await http.patch(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // Update successful
  } else {
    throw Exception('Failed to change password');
  }
}
