import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

Future<Items> getItemById(String itemId) async {
  final response = await http
      .get(Uri.parse('https://utopiaapi.cyclic.app/api/v1/items/$itemId'));

  if (response.statusCode == 200) {
    // print("Hello from getItemBtId ${response.body}");
    // print("Hello from getItembyId2 ${Items.fromJson(jsonDecode(response.body))}");
    return Items.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load item');
  }
}
