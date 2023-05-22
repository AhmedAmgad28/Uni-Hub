import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
  required String passwordConfirm,
  required String phone,
  required String photo,
}) async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/users/signup');
  final request = http.Request('POST', url);

  request.headers.addAll({'Content-Type': 'application/json'});
  request.body = json.encode({
    'name': name,
    'email': email,
    'password': password,
    'passwordConfirm': passwordConfirm,
    'phone': phone,
    'photo': photo,
  });

  final response = await request.send();

  if (response.statusCode == 201) {
    final jsonResponse = await response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .cast<Map<String, dynamic>>()
        .first;
    return jsonResponse;
  }
  if (response.statusCode == 201) {
    final jsonResponse = await response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .cast<Map<String, dynamic>>()
        .first;
    return jsonResponse;
  } else {
    final errorResponse = await response.stream.bytesToString();
    final errorMessage = json.decode(errorResponse)['message'] as String;
    throw Exception('Failed to sign up: $errorMessage');
  }
}
