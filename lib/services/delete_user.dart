import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

Future<void> deleteMe() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/users/deleteMe');
  final response = await http.delete(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 204) {
  } else {
    throw json.decode(response.body)['message'];
  }
}