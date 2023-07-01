import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

//get user info
Future<Map<String, dynamic>> getMe() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  final url = Uri.parse('https://unihub.azurewebsites.net/api/v1/users/me');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody;
  } else {
    throw Exception('Failed to get user data');
  }
}

//i used it to get user ads
Future<Map<String, dynamic>> getUserData() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }

  const url = 'https://unihub.azurewebsites.net/api/v1/users/me';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['data']['user'];
  } else {
    throw Exception('Failed to load user data');
  }
}

//update user info
Future<void> updateProfile(String name, String phone, File photo) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
// Handle token not found error
    throw Exception('Access token not found');
  }
  final url =
      Uri.parse('https://unihub.azurewebsites.net/api/v1/users/updateMe');
  final headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer $token',
  };
  final request = http.MultipartRequest('PATCH', url);
  if (name.isNotEmpty) {
    request.fields['name'] = name;
  }
  if (phone.isNotEmpty) {
    request.fields['phone'] = phone;
  }
  // Scan the file using MediaScannerConnection class
  final scannedUri = await MediaScannerConnection.scanFile(
    photo.path,
    ['image/jpeg'],
  );
  // Add the scanned file to the request
  final scannedFile = File.fromUri(scannedUri);
  request.files.add(await http.MultipartFile.fromPath('photo', scannedFile.path));
  request.headers.addAll(headers);
  final response = await request.send();
  //print(request.headers);
  if (response.statusCode == 200) {
// Update successful
  } else {
    final message =
        jsonDecode(await response.stream.bytesToString())['message'] as String;
    throw Exception(message);
  }
}

//delete user
Future<void> deleteMe() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    // Handle token not found error
    throw Exception('Access token not found');
  }
  final url =
      Uri.parse('https://unihub.azurewebsites.net/api/v1/users/deleteMe');
  final response = await http.delete(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 204) {
  } else {
    throw json.decode(response.body)['message'];
  }
}

class MediaScannerConnection {
  static const MethodChannel _channel = MethodChannel('media_scan');
  static Future<Uri> scanFile(String filePath, List<String> mimeTypes) async {
    // Scan the file and get the URI
    Uri uri = await MediaScannerConnection._scanFile(filePath, mimeTypes);
    return uri;
  }

  // Private method to scan the file
  static Future<Uri> _scanFile(String filePath, List<String> mimeTypes) async {
    try {
      // Call the native platform method to scan the file and get its URI
      final result = await _channel.invokeMethod('scanFile', {
        'path': filePath,
        'mimeTypes': mimeTypes,
      });
      // Parse the result and create a URI
      final uri = Uri.parse(result as String);
      return uri;
    } on PlatformException catch (e) {
      // Handle any errors that occur during the scan
      throw Exception('Error scanning file: $e');
    }
  }
}
