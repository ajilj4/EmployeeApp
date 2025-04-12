import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/clock_card.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/progress_ring.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/search_bar.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_app_bar.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_drawer.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:gateease_employee_app_new/features/qr_code/presentation/providers/qr_code_provider.dart';
import 'package:gateease_employee_app_new/features/qr_code/presentation/widgets/qr_code_bottom_sheet.dart';


class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

@override
  Widget build(BuildContext context) {
    // Listen for QR code sheet state changes
    final showQrSheet = ref.watch(qrBottomSheetProvider);
    
    // Show bottom sheet when QR button is pressed
    if (showQrSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isDismissible: true,
          isScrollControlled: true,
          builder: (context) => const QrCodeBottomSheet(),
        ).then((_) {
          // Reset state when sheet is closed
          ref.read(qrBottomSheetProvider.notifier).state = false;
        });
      });
    }

 
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            
              const SizedBox(height: 16),

              // 🔹 Search Bar
              const CustomSearchBar().animate().fade(duration: 800.ms),

              const SizedBox(height: 16),

              // 🔹 Clock-In Card
              ClockCard().animate().fade(duration: 900.ms).slideY(),

              const SizedBox(height: 16),

              // 🔹 Stats Cards Row
              Row(
                children: [
                  StatsCard(title: "Total days attended", value: "10/31", icon: Icons.calendar_today),
                  StatsCard(title: "Last checked-in", value: "09:20 AM", icon: Icons.access_time),
                ],
              ).animate().fade(duration: 1000.ms).slideX(),

              const SizedBox(height: 16),

              // 🔹 Circular Progress (Attendance %)
              const ProgressRing(progress: 0.72).animate().fade(duration: 1100.ms).scale(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavItemTapped,
      ),
    );
  }
}
