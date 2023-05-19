// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

Future<void> deleteItem(Map<String, dynamic> item) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = 'https://utopiaapi.cyclic.app/api/v1/items/${item['_id']}';

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 204) {
    // Item successfully deleted
  } else {
    throw Exception('Failed to delete item');
  }
}