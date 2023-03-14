import 'package:flutter/material.dart';
import 'package:project_v2/pages/Account_page.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  static String id = 'ChatsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded, color: Colors.black),
          )
        ],
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
