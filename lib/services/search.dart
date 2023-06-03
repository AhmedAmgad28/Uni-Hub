import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> search(String query) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items/search/$query');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final items = data['data']['items'] as List<dynamic>;
    return items;
  } else {
    throw Exception('Failed to search items');
  }
}