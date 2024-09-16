// ignore_for_file: must_be_immutable

import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  bool obscureText;
  String hintText;
  Void? Function()? onTap;
  String? Function(String?)? validator;
  TextInputType textInputType;
  bool? readOnly = false;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    required this.textInputType,
    this.onTap,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onTap: onTap,
      readOnly: readOnly == null ? false : readOnly as bool,
    );
  }
}
