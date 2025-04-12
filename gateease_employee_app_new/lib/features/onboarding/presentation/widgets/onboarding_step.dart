import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gateease_employee_app_new/core/text_styles.dart';

class OnboardingStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingStep({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(imagePath, width: 300),

        const SizedBox(height: 30),

        Text(
          title,
          style: AppTextStyles.onboardingTitle,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        Text(
          description,
          style: AppTextStyles.onboardingDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
