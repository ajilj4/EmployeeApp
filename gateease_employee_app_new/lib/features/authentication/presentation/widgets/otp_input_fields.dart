import 'package:flutter/material.dart';

class OTPInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;

  const OTPInputFields({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 50,
          child: TextField(
            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(counterText: ""),
          ),
        ),
      ),
    );
  }
}
