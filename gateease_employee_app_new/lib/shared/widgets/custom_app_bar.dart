import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gateease_employee_app_new/core/app_icons.dart';
import '../../core/app_routes.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine icon color based on current theme.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(top: 15), // 3px gap above the header.
      child: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Hamburger menu.
            IconButton(
              icon: Icon(Icons.menu, size: 28, color: iconColor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ).animate().fade(duration: 500.ms).scale(),
            
            // Center: Logo.
            SvgPicture.asset(
              AppIcons.bluelogo,
            ).animate().fade(duration: 600.ms).scale(),
            
            // Right: Notification bell with indicator.
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_outlined, size: 28, color: iconColor),
                  onPressed: () {
                    context.go(AppRoutes.notifications);
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 700.ms).scale(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
