// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Api {
//   Future<dynamic> get({required String url, @required String? token}) async {
//     Map<String, String> headers = {};
//     if (token != null) {
//       headers.addAll({
//         'Authorization': 'Bearer $token',
//       });
//     }
//     http.Response response = await http.get(Uri.parse(url), headers: headers);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception(
//           'There is a problem with status code ${response.statusCode}');
//     }
//   }
// }
