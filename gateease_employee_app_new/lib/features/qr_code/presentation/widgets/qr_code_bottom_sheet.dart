import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gateease_employee_app_new/core/app_icons.dart';
import 'package:gateease_employee_app_new/core/app_images.dart';

class QrCodeBottomSheet extends ConsumerWidget {
  final String employeeId;
  
  const QrCodeBottomSheet({
    super.key, 
    this.employeeId = 'EMP1234', // Default or get from user data
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // ✅ Full width
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Handle indicator
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // QR Code
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.mypic, // Use actual QR code or generate it
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                // Logo in center of QR code
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    AppIcons.bluelogo, // Use your app's logo path
                    width: 32,
                    height: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Employee ID
            Text(
              employeeId,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ).animate().slideY(
      begin: 1, 
      end: 0, 
      curve: Curves.easeOutQuart,
      duration: const Duration(milliseconds: 300),
    );
  }
}
