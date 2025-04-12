import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:gateease_employee_app_new/core/app_routes.dart';
import 'package:gateease_employee_app_new/core/text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }


   Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 4));
    
    if (!mounted) return;
    
    try {
      final box = await Hive.openBox('appData');
      if (!mounted) return;
      
      final isFirstTime = box.get('isFirstTime', defaultValue: true);
      
      if (isFirstTime) {
        if (mounted) context.go(AppRoutes.onboarding);
      } else {
        if (mounted) context.go(AppRoutes.dashboard);
      }
    } catch (e) {
      if (mounted) context.go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002D6A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Logo Animation
            SvgPicture.asset('assets/icons/logo.svg', width: 220)
                .animate()
                .fadeIn(duration: 1.5.seconds)
                .scaleXY(
                  begin: 1.0,
                  end: 1.0,
                  duration: 1.5.seconds,
                )
                .then()
                .scaleXY(begin: 1.0, end: 1.0, duration: 0.5.seconds),

            const SizedBox(height: 25),

            // ✅ Text Animation
            Text(
              "GateEase",
              style: AppTextStyles.gateEaseTitle,
              textAlign: TextAlign.center,
            ).animate(),
          ],
        ),
      ),
    )
         .animate()
        .fadeIn(duration: 1.seconds)
        .then(delay: 2.seconds)
        .moveX(begin: 0, end: MediaQuery.of(context).size.width / 3, duration: 1.5.seconds)
        .scaleXY(
          begin: 1.0,
          end: 100.0, // ✅ Zoom effect at the end
          duration: 1.5.seconds,
          curve: Curves.easeInOut,
        )
        .then()
        .tint(color: Colors.white, duration: 0.7.seconds);
  }
}
