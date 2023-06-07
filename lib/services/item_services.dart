// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:io';
import 'dart:convert';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

//get all items 
Future<itemsModel> getAllServices() async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}



//get all items by category
Future<itemsModel> getitemsByCategory(String category) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items?category=$category');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}



//get the info of a single product
Future<Items> getItemById(String itemId) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
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



//add product
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



//update item by the user published it
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



//delete item by user published it
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