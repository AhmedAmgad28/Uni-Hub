import 'package:flutter/material.dart';

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
        backgroundColor: Colors.grey,
        title: Text(
          'Sell Your Product',
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