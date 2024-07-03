import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, left: 10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 244, 0, 0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
