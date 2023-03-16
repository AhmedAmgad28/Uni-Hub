// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static String id = 'AccountPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
