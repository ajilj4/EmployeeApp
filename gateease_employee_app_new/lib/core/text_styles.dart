import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle gateEaseTitle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600, // Matches font-weight: 600
    fontSize: 26, // Matches font-size: 26px
    height: 39 / 26, // Matches line-height: 39px
    letterSpacing: 0, // Matches letter-spacing: 0%
    textBaseline: TextBaseline.alphabetic,
    color: Colors.white,
  );

  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.5,
    letterSpacing: 0.2,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle onboardingDescription = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: Colors.grey,
  );

   static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: Color(0xFF707170),
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

   static const TextStyle inputLabel = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 21 / 14, // line-height: 21px
    letterSpacing: 0,
    color: Colors.black,
  );
}
