import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gateease_employee_app_new/core/app_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateease_employee_app_new/features/qr_code/presentation/providers/qr_code_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDFE2DF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, AppIcons.home),
                  _buildNavItem(1, AppIcons.copy),
                  _buildProfileItem(2),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildQrCodeButton(context, ref),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.blue : Colors.grey.shade500,
                BlendMode.srcIn,
              ),
            ).animate(target: isSelected ? 1 : 0)
             .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
          if (isSelected)
            Container(
              width: 24,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ).animate()
             .slideY(begin: 0.5, end: 0, duration: 200.ms)
             .fadeIn(duration: 200.ms),
        ],
      ),
    );
  }

  Widget _buildProfileItem(int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: const AssetImage("assets/images/dummy_profile.png"),
              ),
            ).animate(target: isSelected ? 1 : 0)
             .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
          if (isSelected)
            Container(
              width: 24,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ).animate()
             .slideY(begin: 0.5, end: 0, duration: 200.ms)
             .fadeIn(duration: 200.ms),
        ],
      ),
    );
  }

  Widget _buildQrCodeButton(BuildContext context, WidgetRef ref) {
     bool isSelected = selectedIndex == 3;
    return GestureDetector(
      onTap: () {
        ref.read(qrBottomSheetProvider.notifier).state = true;
      } ,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : const Color(0xFFFFEFD9),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.qrCode,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.grey.shade500,
              BlendMode.srcIn,
            ),
          ),
        ),
      ).animate(target: isSelected ? 1 : 0)
       .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
    );
  }
}