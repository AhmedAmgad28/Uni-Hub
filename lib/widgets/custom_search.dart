import 'package:flutter/material.dart';

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
      },
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: (){

          },
          child: const Icon(Icons.search)
        ),
        hintText: hintText!,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.grey,width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(color: Colors.grey,width: 1),
        ),
      ),
    );
  }
}