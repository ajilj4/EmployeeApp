

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Custom duration extension - renamed to avoid conflict
extension AppDurationExtension on num {
  Duration get msec => Duration(milliseconds: toInt());
}

// Animation utilities
class AppAnimations {
  // Standard durations
  static const defaultDuration = 600;
  
  // Pre-configured animations
  static Widget fadeIn(Widget widget) {
    return widget.animate().fadeIn(duration: Duration(milliseconds: defaultDuration));
  }
  
  static Widget slideUp(Widget widget) {
    // For slideY, we need to use begin/end as doubles, not Offset objects
    return widget.animate().slideY(
      begin: 1.0, 
      end: 0.0, 
      duration: Duration(milliseconds: defaultDuration)
    );
  }
  
  static Widget scaleIn(Widget widget) {
    return widget.animate().scaleXY(
      begin: 0.8, 
      end: 1.0, 
      duration: Duration(milliseconds: defaultDuration)
    );
  }
}
