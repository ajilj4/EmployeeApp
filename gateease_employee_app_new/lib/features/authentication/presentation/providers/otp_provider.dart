import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  return OtpNotifier();
});

class OtpNotifier extends StateNotifier<OtpState> {
  OtpNotifier() : super(OtpState());

  void updateOtp(String value, int index) {
    final otpList = [...state.otp];
    otpList[index] = value;
    state = state.copyWith(otp: otpList);
  }

  void startResendTimer() {
    if (state.resendTimer > 0) return;

    state = state.copyWith(resendTimer: 12);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer == 0) {
        timer.cancel();
      } else {
        state = state.copyWith(resendTimer: state.resendTimer - 1);
      }
    });
  }

  void verifyOtp() {
    final otpCode = state.otp.join();
    if (otpCode.length == 4) {
      // Simulate API call
      print("Verifying OTP: $otpCode");
    }
  }
}

class OtpState {
  final List<String> otp;
  final int resendTimer;

  OtpState({this.otp = const ["", "", "", ""], this.resendTimer = 0});

  OtpState copyWith({List<String>? otp, int? resendTimer}) {
    return OtpState(
      otp: otp ?? this.otp,
      resendTimer: resendTimer ?? this.resendTimer,
    );
  }
}
