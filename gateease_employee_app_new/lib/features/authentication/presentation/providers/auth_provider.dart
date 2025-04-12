import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/entities/user.dart';
import 'package:gateease_employee_app_new/features/authentication/domain/usecases/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:gateease_employee_app_new/core/errors/failure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(GetIt.I<LoginUseCase>());
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final LoginUseCase loginUseCase;

  AuthNotifier(this.loginUseCase) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    
    final Either<Failure, User> result = await loginUseCase(email, password);

    result.fold(
      (failure) {
        // 🔹 Show error in a toast message (Top Center)
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
        state = AsyncValue.data(user);
      },
    );
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}
