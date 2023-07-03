// ignore_for_file: unused_local_variable, prefer_const_constructors
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

//get all items
Future<itemsModel> getAllServices() async {
  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/items?page=0');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}

//get Sorted items
Future<itemsModel> getSortedItems(
    int minPrice, int maxPrice, String sortBy) async {
  final url = Uri.parse(
      'https://unihub.azurewebsites.net/api/v1/items?price[gte]=$minPrice&price[lte]=$maxPrice&sort=$sortBy');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}

//get all items by category
Future<itemsModel> getitemsByCategory(String category) async {
  final url = Uri.parse(
      'https://unihub.azurewebsites.net/api/v1/items?category=$category');
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
    Uri.parse('https://unihub.azurewebsites.net/api/v1/items/$itemId'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body)['data']['item'];
    final locationJson = jsonResponse['location'];
    final location = Location(
      coordinates: List<double>.from(locationJson['coordinates']),
      address: locationJson['address'],
      description: locationJson['description'],
      geoType: locationJson['geoType'],
    );
    final imgsJson = jsonResponse['imgs'];
    final imgs = List<String>.from(imgsJson);
    return Items(
      title: jsonResponse['title'],
      price: jsonResponse['price'],
      description: jsonResponse['description'],
      coverImg: jsonResponse['coverImg'],
      category: jsonResponse['category'],
      condition: jsonResponse['condition'],
      city: jsonResponse['city'],
      createAt: jsonResponse['createAt'],
      user: User.fromJson(jsonResponse['user']),
      location: location,
      imgs: imgs,
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
  required String category,
  required String condition,
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

  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/items');

  final request = http.MultipartRequest('POST', url)
    ..headers['Authorization'] = 'Bearer $token'
    ..fields.addAll({
      'title': title,
      'price': price.toString(),
      'description': description,
      'category': category,
      'condition': condition,
      'city': city,
      'location': jsonEncode({
        'type': 'point',
        'coordinates': [lng, lat],
        'address': address,
        'description': locationDescription,
      }),
    });

  final response = await request.send().timeout(Duration(seconds: 60));
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode == 201) {
    return http.Response(responseBody, response.statusCode);
  } else if (response.statusCode == 504) {
    throw TimeoutException('Request timed out');
  } else {
    throw Exception(
        jsonDecode(await response.stream.bytesToString())['message']);
  }
}

//add images to the new item
Future<void> updateItemImages({
  required String itemId,
  required File coverImg,
  required List<File> imgs,
  required String contentType,
}) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = 'https://unihub.azurewebsites.net/api/v1/items/$itemId';

  final request = http.MultipartRequest('PATCH', Uri.parse(url))
    ..headers['Authorization'] = 'Bearer $token';

  request.files
      .add(await http.MultipartFile.fromPath('coverImg', coverImg.path, contentType: MediaType.parse(contentType),));

  for (final imgFile in imgs) {
    final contentType = lookupMimeType(imgFile.path);
    if (contentType == null || !contentType.startsWith('image/')) {
      throw Exception('File $imgFile is not recognized as an image file.');
    }
    final fileName = imgFile.path.split('/').last;
    request.files.add(await http.MultipartFile.fromPath('imgs', imgFile.path,
        contentType: MediaType.parse(contentType)));
  }

  final response = await http.Client().send(request);

  if (response.statusCode == 200) {
    // Handle the updated item
  } else if (response.statusCode == 504) {
    throw TimeoutException('Request timed out');
  } else {
    throw Exception('Failed to update item. ${response.statusCode}');
  }
}

//update item by the user published it
Future<void> updateItem(
    Map<String, dynamic> item, Map<String, dynamic> updatedValues) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = 'https://unihub.azurewebsites.net/api/v1/items/${item['_id']}';

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

  final url = 'https://unihub.azurewebsites.net/api/v1/items/${item['_id']}';

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
