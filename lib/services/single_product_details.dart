// ignore_for_file: prefer_const_constructors

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<Items> getItemById(String itemId) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final response = await http.get(
    Uri.parse('https://utopiaapi.cyclic.app/api/v1/items/$itemId'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body)['data']['item'];
    return Items(
      title: jsonResponse['title'],
      price: jsonResponse['price'],
      description: jsonResponse['description'],
      coverImg: jsonResponse['coverImg'],
      category: jsonResponse['category'],
      city: jsonResponse['city'],
      createAt: jsonResponse['createAt'],
      user: User.fromJson(jsonResponse['user']),
    );
  } else {
    throw Exception('Failed to load item');
  }
}