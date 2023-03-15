import 'package:flutter/material.dart';
import 'package:project_v2/pages/Account_page.dart';
import 'package:project_v2/widgets/chat_cards.dart';

import '../helper/constants.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  static String id = 'ChatsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColor,
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
      body: ListView(
        children: [
          SizedBox(height: 4,),
          ChatCards(),
          ChatCards(),
        ],
      ),
    );
  }
}
