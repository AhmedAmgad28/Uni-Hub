// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap,required this.buttonText});

  VoidCallback? onTap;
  String? buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Center(
          child: Text(
            '$buttonText',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}