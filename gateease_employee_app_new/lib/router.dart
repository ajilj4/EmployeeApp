import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:gateease_employee_app_new/core/app_routes.dart';
import 'package:gateease_employee_app_new/features/splash/presentation/pages/splash_page.dart';
import 'package:gateease_employee_app_new/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/login_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/otp_login_page.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gateease_employee_app_new/features/notifications/presentation/pages/notifications_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: AppRoutes.onboarding, 
        builder: (context, state) => const OnboardingPage(),
        redirect: (context, state) async {
          // Check if it's first time launch, otherwise redirect to login
          try {
            final box = await Hive.openBox('appData');
            final isFirstTime = box.get('isFirstTime', defaultValue: true);
            
            if (!isFirstTime) {
              // Not first time, redirect to login
              return AppRoutes.login;
            }
          } catch (e) {
            // If can't check, allow navigation to onboarding
          }
          return null;
        },
      ),
      GoRoute(
        path: AppRoutes.login, 
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) async {
          // If already authenticated, redirect to dashboard
          try {
            final box = await Hive.openBox('auth');
            final token = box.get('token');
            
            if (token != null) {
              return AppRoutes.dashboard;
            }
          } catch (e) {
            // If can't check, allow navigation to login
          }
          return null;
        },
      ),
      GoRoute(path: AppRoutes.loginOTP, builder: (context, state) => OtpLoginPage()),
      GoRoute(path: AppRoutes.otpVerification, builder: (context, state) => OtpVerificationPage()),
      GoRoute(
        path: AppRoutes.dashboard, 
        builder: (context, state) => const DashboardPage(),
        redirect: (context, state) async {
          // Check if authenticated, if not redirect to login
          try {
            final box = await Hive.openBox('auth');
            final token = box.get('token');
            
            if (token == null) {
              return AppRoutes.login;
            }
          } catch (e) {
            return AppRoutes.login;
          }
          return null;
        },
      ),
      GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationsPage()),
    ],
  );
});