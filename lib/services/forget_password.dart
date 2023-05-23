import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> forgotPassword(String email) async {
  const url = 'https://utopiaapi.cyclic.app/api/v1/users/forgetPassword';

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