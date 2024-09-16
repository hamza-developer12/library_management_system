import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;
  CustomButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
