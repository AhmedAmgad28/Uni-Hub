// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class RegisterFormTextField extends StatelessWidget {
  const RegisterFormTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText!,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}