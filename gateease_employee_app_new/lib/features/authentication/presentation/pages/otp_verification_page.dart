import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/app_icons.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/animations.dart';
import '../providers/otp_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_header.dart';

class OtpVerificationPage extends ConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpProvider);
    final otpNotifier = ref.read(otpProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated Header
              AppAnimations.fadeIn(
                CustomHeader(
                  title: "OTP Verification",
                  subtitle: "Enter the OTP sent to your registered email to verify your identity securely.",
                  svgImage: AppIcons.otpImage,
                ),
              ),
              const SizedBox(height: 24),

              // OTP Input Fields with Staggered Animation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) {
                        otpNotifier.updateOtp(value, index);
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                      .animate()
                      .fade(duration: 300.ms, delay: (index * 200).ms)
                      .slideY(begin: 0.5);
                }),
              ),

              const SizedBox(height: 16),

              // Animated Resend Timer or Button
              Align(
                alignment: Alignment.centerRight,
                child: otpState.resendTimer > 0
                    ? Text(
                        "00:${otpState.resendTimer.toString().padLeft(2, '0')} Resend",
                        style: AppTextStyles.subtitle,
                      )
                    : TextButton(
                        onPressed: otpNotifier.startResendTimer,
                        child: Text("Resend OTP", style: AppTextStyles.linkText),
                      ),
              ).animate().fade(duration: 400.ms, delay: 600.ms),

              const SizedBox(height: 24),

              // Animated Sign-in Button
              AppAnimations.scaleIn(
                CustomButton(
                  text: "Sign in",
                  onPressed: otpNotifier.verifyOtp,
                ),
              ),

              const SizedBox(height: 16),

              // Animated Switch to Password Login
              Center(
                child: TextButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  child: Text("Sign in via Password?", style: AppTextStyles.linkText),
                ),
              ).animate().fade(duration: 400.ms, delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
