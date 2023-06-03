import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

Future<itemsModel> getAllServices() async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<itemsModel> getitemsByCategory(String category) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items?category=$category');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}