// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {super.key, required this.hintText, this.onChanged, this.obscureText = false, this.inputType});

  Function(String)? onChanged;
  String? hintText;
  bool? obscureText;
  TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      keyboardType: inputType,
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
          borderSide: BorderSide(color: kPrimaryColor,width: 2),
        ),    
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.black,width: 2),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.black,width: 2),
        ),
      ),
    );
  }
}