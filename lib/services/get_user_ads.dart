import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> getUserData() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  const url = 'https://utopiaapi.cyclic.app/api/v1/users/me';

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