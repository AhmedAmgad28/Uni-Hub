// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../helper/constants.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField(
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
      style: const TextStyle(color: kPrimaryColor,fontSize: 14),
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        fillColor: kBackgroundColor,
        prefixIcon: GestureDetector(
          onTap: (){

          },
          child: const Icon(Icons.search,color: kPrimaryColor,)
        ),
        hintText: hintText!,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor,width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 0),
        ),
      ),
    );
  }
}