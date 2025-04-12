import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gateease_employee_app_new/core/app_routes.dart';
import 'package:gateease_employee_app_new/core/app_icons.dart';
import 'package:gateease_employee_app_new/core/text_styles.dart';
import 'package:gateease_employee_app_new/features/onboarding/presentation/widgets/onboarding_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _steps = [
    {
      "image": AppIcons.onboard1,
      "title": "Mark Attendance in Seconds!",
      "description":
          "Tap once to check in or out. Stay updated with real-time tracking.",
    },
    {
      "image": AppIcons.onboard2,
      "title": "Hassle-free Pass Creation",
      "description":
          "Generate work passes, request approvals, and manage visitor entries seamlessly.",
    },
    {
      "image": AppIcons.onboard3,
      "title": "Effortless Offline Attendance!",
      "description": "Mark attendance smoothly, even without the Internet.",
    },
    {
      "image": AppIcons.onboard4,
      "title": "Never Miss an Update!",
      "description":
          "Get real-time notifications for approvals, reminders, and attendance updates.",
    },
  ];

  Future<void> _completeOnboarding() async {
    var box = await Hive.openBox('appData');
    await box.put('isFirstTime', false);

    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _steps.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final step = _steps[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OnboardingStep(
                      imagePath: step["image"]!,
                      title: step["title"]!,
                      description: step["description"]!,
                    )
                    .animate()
                    .fadeIn(duration: 1.seconds)
                    .moveY(begin: 10, end: 0, duration: 0.8.seconds),
              );
            },
          ),

          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Column(
              children: [
                SmoothPageIndicator(
                      controller: _pageController,
                      count: _steps.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Color(0xFF002D6A),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 1.seconds)
                    .moveY(begin: 10, end: 0, duration: 0.8.seconds),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        "Skip",
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: Colors.grey,
                        ), // ✅ Consistent
                      ),
                    ).animate().fadeIn(duration: 1.seconds),

                    TextButton(
                      onPressed: () {
                        if (_currentIndex < _steps.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _completeOnboarding();
                        }
                      },
                      child: Text(
                        _currentIndex == _steps.length - 1
                            ? "Let's Go →"
                            : "Next",
                        style: AppTextStyles.onboardingTitle.copyWith(
                          color: Colors.black,
                        ), // ✅ Black text
                      ),
                    ).animate().fadeIn(duration: 1.seconds),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
