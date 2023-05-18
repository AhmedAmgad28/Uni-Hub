import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addProduct({
  required String title,
  required double price,
  required String description,
  required String coverImg,
  required List<String> imgs,
  required String category,
  required String city,
  required double lat,
  required double lng,
  required String address,
  required String locationDescription,
  required String accessToken, // Add this parameter for the access token
}) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');

  final data = {
    'title': title,
    'price': price,
    'description': description,
    'coverImg': coverImg,
    'imgs': imgs,
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
      'Authorization': 'Bearer $accessToken', // Add the Authorization header with the token value
    },
  );

  if (response.statusCode == 200) {
    // Success
  } else {
    // Error
  }
}