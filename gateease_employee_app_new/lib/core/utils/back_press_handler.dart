import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BackPressHandler {
  DateTime? _lastBackPressTime;
  
  /// Handles back button press with double-tap to exit functionality
  /// Returns true if the app should exit, false otherwise
  bool handleBackPress() {
    final now = DateTime.now();
    if (_lastBackPressTime == null || 
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      // First press, show toast
      _lastBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      return false;
    }
    
    // Second press within 2 seconds, exit the app
    return true;
  }
}