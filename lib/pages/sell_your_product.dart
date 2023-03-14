import 'package:flutter/material.dart';

class SellProductPage extends StatelessWidget {
  const SellProductPage({super.key});

  static String id = 'SellProductPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Sell Your Product',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}