// ignore_for_file: prefer_const_declarations, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

  Future<void> updateItem(
      Map<String, dynamic> item, Map<String, dynamic> updatedValues) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      // Handle token not found error
      throw Exception('Access token not found');
    }

    final url = 'https://utopiaapi.cyclic.app/api/v1/items/${item['_id']}';

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(updatedValues),
    );

    if (response.statusCode == 200) {
      final updatedItem = json.decode(response.body)['data']['item'];
      // Handle the updated item
    } else {
      throw Exception('Failed to update item');
    }
  }
