import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> login(
    {required String email, required String password}) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/users/login');
  final request = http.Request('POST', url);

  request.headers.addAll({'Content-Type': 'application/json'});
  request.body = json.encode({'email': email, 'password': password});

  final response = await request.send();

  if (response.statusCode == 200) {
    final jsonResponse = await response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .cast<Map<String, dynamic>>()
        .first;

    final token = jsonResponse['token'];
    await storage.write(key: 'token', value: token);
    print(jsonResponse);
    print(token);
    return jsonResponse;
  } else {
    throw Exception('Failed to login');
  }
}
