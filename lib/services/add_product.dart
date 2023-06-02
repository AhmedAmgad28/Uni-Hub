import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<http.Response> addProduct({
  required String title,
  required double price,
  required String description,
  required String coverImgPath,
  required List<File> imgs,
  required String category,
  required String city,
  required double lat,
  required double lng,
  required String address,
  required String locationDescription,
}) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');

  final imgNames = imgs.map((file) => file.path.split('/').last).toList();
  final coverImg = coverImgPath.split('/').last.replaceAll("'", "");

  final data = {
    'title': title,
    'price': price,
    'description': description,
    'coverImg': coverImg,
    'imgs': imgNames,
    'category': category,
    'city': city,
    'location': {
      'type': 'point',
      'coordinates': [lng, lat],
      'address': address,
      'description': locationDescription,
    },
  };

  final response = await http.post(
    url,
    body: jsonEncode(data),
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $token', // Add the Authorization header with the token value
    },
  );
  return response;
}
