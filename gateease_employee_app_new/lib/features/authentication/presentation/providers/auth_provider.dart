// features/authentication/presentation/providers/auth_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/usecases/login_usecase.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:gateease_employee_app_new/core/errors/failure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(
    GetIt.I<LoginUseCase>(),
    GetIt.I<LogoutUseCase>(),
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthNotifier(this.loginUseCase, this.logoutUseCase) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      
      final Either<Failure, User> result = await loginUseCase(email, password);
      
      result.fold(
        (failure) {
          // Show error in a toast message
          Fluttertoast.showToast(
            msg: failure.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );

          state = AsyncValue.error(failure, StackTrace.current);
        },
        (user) {
          // Add success toast
          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          
          state = AsyncValue.data(user);
        },
      );
    } catch (e) {
      print("Auth Provider login error: $e");
      
      Fluttertoast.showToast(
        msg: "An unexpected error occurred",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      
      state = AsyncValue.error(
        ServerFailure("An unexpected error occurred"), 
        StackTrace.current
      );
    }
  }

  Future<void> logout() async {
    try {
      state = const AsyncValue.loading();
      
      final result = await logoutUseCase();
      
      result.fold(
        (failure) {
          Fluttertoast.showToast(
            msg: failure.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          
          // Even if clearing local storage fails, we still set auth state to null
          state = const AsyncValue.data(null);
        },
        (_) {
          Fluttertoast.showToast(
            msg: "Logged out successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          
          state = const AsyncValue.data(null);
        },
      );
    } catch (e) {
      print("Auth Provider logout error: $e");
      
      // Even on error, we still set auth state to null
      state = const AsyncValue.data(null);
    }
  }
}