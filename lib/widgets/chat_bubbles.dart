import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_v2/helper/constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String date;
  final bool isMe;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.date,
    required this.isMe,
  }) : super(key: key);

  
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('hh:mm a');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? kPrimaryColor : const Color.fromARGB(255, 133, 84, 203),
          borderRadius: BorderRadius.only(
            topLeft:
                isMe ? const Radius.circular(15) : const Radius.circular(0),
            topRight:
                isMe ? const Radius.circular(0) : const Radius.circular(15),
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              reverseDateFormat(date),
              style: const TextStyle(
                color: Color.fromARGB(255, 207, 207, 207),
              ),
              textAlign: TextAlign.right,
              
            ),
          ],
        ),
      ),
    );
  }
}
