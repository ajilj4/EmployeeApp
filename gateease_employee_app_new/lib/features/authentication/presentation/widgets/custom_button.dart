import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006EFF), // 🔹 Button Color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 🔹 Rounded Corners
          ),
          elevation: 0, // 🔹 No Shadow
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white, // 🔹 White Text
          ),
        ),
      ),
    );
  }
}
