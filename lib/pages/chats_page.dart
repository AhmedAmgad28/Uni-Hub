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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded, color: kBackgroundColor),
          )
        ],
        title: const Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            'Chats',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 4,),
          ChatCards(),
          ChatCards(),
        ],
      ),
    );
  }
}
