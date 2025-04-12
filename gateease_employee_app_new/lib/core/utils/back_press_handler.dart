import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BackPressHandler {
  DateTime? _lastBackPressTime;
  
  Future<bool> handleBackPress() async {
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
    // This is a more gentle way to exit the app compared to exit(0)
    SystemNavigator.pop();
    return false; // Return false to prevent default back navigation
  }
}