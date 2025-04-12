import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gateease_employee_app_new/core/app_routes.dart';
import 'package:gateease_employee_app_new/features/splash/presentation/pages/splash_page.dart';
import 'package:gateease_employee_app_new/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/login_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/otp_login_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gateease_employee_app_new/features/notifications/presentation/pages/notifications_page.dart'; // ✅ Import Notifications Page

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingPage()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => LoginPage()),
      GoRoute(path: AppRoutes.loginOTP, builder: (context, state) => OtpLoginPage()),
      GoRoute(path: AppRoutes.otpVerification, builder: (context, state) => OtpVerificationPage()),
      GoRoute(path: AppRoutes.dashboard, builder: (context, state) => const DashboardPage()),
      GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationsPage()), // ✅ Added Notifications Route
    ],
  );
});
