import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

//get all chatrooms related to the user
Future<Map<String, dynamic>> fetchChatRooms() async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    throw Exception('Access token not found');
  }

  final response = await http.get(
    Uri.parse('https://utopiaapi.cyclic.app/api/v1/chatRooms'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch chat rooms');
  }
}



//get single chat room
Future<Map<String, dynamic>> singleChatRoom(String chatRoomID) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    throw Exception('Access token not found');
  }

  final response = await http.get(
    Uri.parse('https://utopiaapi.cyclic.app/api/v1/chatRooms/$chatRoomID'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch chat rooms');
  }
}




//send message
Future<Map<String, dynamic>> postMessage(
    String chatRoomId, String messageContent) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    throw Exception('Access token not found');
  }

  final url = Uri.parse(
      'https://utopiaapi.cyclic.app/api/v1/chatRooms/$chatRoomId/messages');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({'content': messageContent});
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode != 201) {
    throw Exception('Failed to post message: ${response.body}');
  }
  final responseData = jsonDecode(response.body);
  final messages = responseData['messages'];
  final mostRecentMessage = messages.isNotEmpty ? messages[0] : null;
  return mostRecentMessage;
}




//create a chat room
Future<Map<String, dynamic>> createChatRoom(String receiverUserId) async {
  final token = await storage.read(key: 'token');
  if (token == null) {
    throw Exception('Access token not found');
  }
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/chatRooms');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({'reciever': receiverUserId});
  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 201 || response.statusCode == 200) {
    final responseData = response.body;
  final chatRoom = jsonDecode(responseData)['chatRoom'];
  return {
    'status': 'Success',
    'date': jsonDecode(responseData)['date'],
    'chatRoom': chatRoom,
  };
  } else {
    throw Exception('Failed to create chat room: ${response.statusCode}');
  }
}
