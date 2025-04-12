import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateease_employee_app_new/core/app_images.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gateease_employee_app_new/core/app_routes.dart';
import 'package:gateease_employee_app_new/features/authentication/presentation/providers/auth_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // User Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(AppImages.mypic),
                  ).animate().scale(duration: 700.ms),
                  const SizedBox(width: 12),
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Ajil",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "ajilj4@gmail.com",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Operations Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Operations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "manage",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Operations Menu Items
            _buildMenuItem(
              context, 
              "Attendance", 
              icon: null,
              onTap: () => context.go(AppRoutes.dashboard),
            ),
            _buildMenuItem(
              context, 
              "Appointment", 
              icon: null,
              onTap: () {},
            ),
            _buildMenuItem(
              context, 
              "Material out pass", 
              icon: null,
              onTap: () {},
            ),
            _buildMenuItem(
              context, 
              "Approvals", 
              icon: null,
              onTap: () {},
            ),
            
            const Spacer(),
            
            // Footer Items
            _buildMenuItem(
              context, 
              "Settings", 
              icon: Icons.settings,
              onTap: () {},
            ),
            _buildMenuItem(
              context, 
              "Logout", 
              icon: Icons.logout,
              textColor: Colors.red,
              onTap: () {
                // Call the logout function from the AuthNotifier
                ref.read(authProvider.notifier).logout().then((_) {
                  // After logout completes, navigate to login page
                  context.go(AppRoutes.login);
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuItem(
    BuildContext context, 
    String title, 
    {IconData? icon, 
    Color? textColor, 
    required VoidCallback onTap}
  ) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: textColor ?? Colors.grey[800]) : null,
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: icon == null ? Icon(Icons.chevron_right, color: Colors.grey) : null,
      onTap: onTap,
    );
  }
}