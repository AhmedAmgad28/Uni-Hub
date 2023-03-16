import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class SellProductPage extends StatelessWidget {
  const SellProductPage({super.key});

  static String id = 'SellProductPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Sell Your Product',
          style: TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}