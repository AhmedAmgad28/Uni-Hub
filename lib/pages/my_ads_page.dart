import 'package:flutter/material.dart';
import 'package:project_v2/pages/Account_page.dart';

import '../widgets/custom_card.dart';
import '../widgets/myads_custom_cards.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});
  static String id = 'MyAdsPage';

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
          'My Ads',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 8,
          ),
          MyAdsCustomCard(),
          SizedBox(
            height: 8,
          ),
          MyAdsCustomCard(),
        ],
      ),
    );
  }
}
