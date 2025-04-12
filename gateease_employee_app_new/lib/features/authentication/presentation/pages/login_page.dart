import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/app_icons.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/animations.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_header.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authNotifier = ref.read(authProvider.notifier);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    await authNotifier.login(email, password);
  }

  Future<bool> _shouldAllowPop() async {
    try {
      final box = await Hive.openBox('appData');
      final isFirstTime = box.get('isFirstTime', defaultValue: true);
      return !isFirstTime; // Only allow pop if NOT first time
    } catch (_) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            print("User authenticated, navigating to dashboard");
            context.go(AppRoutes.dashboard);
          }
        },
        error: (error, _) {
          print("Auth error in listener: $error");
        },
      );
    });

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final allow = await _shouldAllowPop();
        if (allow && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAnimations.fadeIn(
                    CustomHeader(
                      title: "Sign In To Your Account",
                      subtitle:
                          "Sign in to access your attendance and manage appointments easily",
                      svgImage: AppIcons.logo,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppAnimations.slideUp(
                    CustomTextField(
                      label: 'Email',
                      hintText: "example@gmail.com",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppAnimations.slideUp(
                    CustomTextField(
                      label: 'Password',
                      hintText: "Password",
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(AppIcons.lock),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  AppAnimations.fadeIn(
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Handle forgot password
                        },
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.linkText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppAnimations.scaleIn(
                    CustomButton(
                      text: authState.when(
                        data: (_) => "Sign in",
                        loading: () => "Signing in...",
                        error: (_, __) => "Sign in",
                      ),
                      onPressed: authState.maybeWhen(
                        loading: () => () {},
                        orElse: () => _onLogin,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppAnimations.fadeIn(
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.go(AppRoutes.loginOTP);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Sign in via ",
                            style: AppTextStyles.linkText,
                            children: [
                              TextSpan(
                                text: "OTP",
                                style: AppTextStyles.linkText.copyWith(
                                  color: Colors.orange,
                                ),
                              ),
                              const TextSpan(text: "?"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
