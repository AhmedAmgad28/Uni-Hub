import 'package:flutter/material.dart';
import 'package:project_v2/pages/Account_page.dart';
import 'package:project_v2/widgets/custom_textfield.dart';

import '../widgets/custom_card.dart';
import '../widgets/custom_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

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
          'Uni-Hub',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          SearchTextField(hintText: 'Search for products'),
          SizedBox(
            height: 8,
          ),
          CustomCard(),
          SizedBox(
            height: 8,
          ),
          CustomCard(),
        ],
      ),
    );
  }
}
