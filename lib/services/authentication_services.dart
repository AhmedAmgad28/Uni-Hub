// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

//login function
Future<Map<String, dynamic>> login(
    {required String email, required String password}) async {
  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/login');
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
    return jsonResponse;
  } else {
    final responseBody = await response.stream.bytesToString();
    final errorMessage = json.decode(responseBody)['message'];
    throw (errorMessage);
  }
}

//register function
Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
  required String passwordConfirm,
  required String phone,
  required String photo,
}) async {
  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/signup');
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
    final responseBody = await response.stream.bytesToString();
    final errorMessage = json.decode(responseBody)['message'];
    throw (errorMessage);
  }
}

//forget password function
Future<void> forgotPassword(String email) async {
  const url = 'https://unihub.azurewebsites.net/api/v1/users/forgetPassword';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({'email': email}),
  );

  if (response.statusCode == 200) {
    // Password reset link sent successfully
  } else {
    // Handle the error
    throw Exception('Failed to send password reset link');
  }
}

//change password function
Future<void> changePassword(
    String password, String newPassword, String newPasswordConfirm) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url =
      Uri.parse('https://unihub.azurewebsites.net/api/v1/users/updatePassword');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'password': password,
    'newPassword': newPassword,
    'newPasswordConfirm': newPasswordConfirm,
  });
  final response = await http.patch(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // Update successful
  } else {
    throw Exception('Failed to change password');
  }
}
