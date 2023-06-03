// ignore_for_file: file_names
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<List<Items>> getFavourites() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final response = await http.get(
    Uri.parse('https://utopiaapi.cyclic.app/api/v1/items/Fav-Items'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['favItems'] as List<dynamic>;
    return data.map((item) => Items.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<void> updateFavoriteItem(String itemId) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  
  final response = await http.patch(
    Uri.parse('https://utopiaapi.cyclic.app/api/v1/items/Fav-Items/$itemId'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to update favorite item');
  }
}