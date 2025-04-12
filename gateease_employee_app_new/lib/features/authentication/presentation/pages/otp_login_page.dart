import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/app_icons.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/animations.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_header.dart';

class OtpLoginPage extends StatelessWidget {
  const OtpLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAnimations.fadeIn(
                CustomHeader(
                  title: "Sign In To Your Account",
                  subtitle: "Sign in to access your attendance and manage appointments easily",
                  svgImage: AppIcons.otpImage,
                ),
              ),
              const SizedBox(height: 24),
              AppAnimations.slideUp(
                CustomTextField(
                  label: 'Email',
                  hintText: "example@gmail.com",
                  controller: emailController,
                ),
              ),
              const SizedBox(height: 24),
              AppAnimations.scaleIn(
                CustomButton(
                  text: "Send OTP",
                  onPressed: () {
                    context.go(AppRoutes.otpVerification);
                  },
                ),
              ),
              const SizedBox(height: 16),
              AppAnimations.fadeIn(
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRoutes.login);
                    },
                    child: Text("Sign in via Password?", style: AppTextStyles.linkText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
