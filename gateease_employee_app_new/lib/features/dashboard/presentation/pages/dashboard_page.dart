// lib/features/dashboard/presentation/pages/dashboard_page.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your actual widgets.
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/custom_search_bar.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/search_bar_skeleton.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/toggle_theme_widget.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/clock_card.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/clock_card_skeleton.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/stats_card_skeleton.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/progress_ring.dart';
import 'package:gateease_employee_app_new/features/dashboard/presentation/widgets/progress_ring_skeleton.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_app_bar.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:gateease_employee_app_new/shared/widgets/custom_drawer.dart';

// Providers for search text and loading state.
final searchProvider = StateProvider<String>((_) => '');
final isDashboardLoadingProvider = StateProvider<bool>((_) => true);

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
  void initState() {
    super.initState();
    // Simulate a 3-second loading delay for the entire dashboard.
    Timer(const Duration(seconds: 3), () {
      ref.read(isDashboardLoadingProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isDashboardLoadingProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar or its skeleton.
            isLoading
                ? const SearchBarSkeleton()
                : const CustomSearchBar(),
            const SizedBox(height: 16),
            // ClockCard or its skeleton.
            isLoading
                ? const ClockCardSkeleton()
                : const ClockCard(),
            const SizedBox(height: 16),
            // Two StatsCards (each with its skeleton).
            Row(
              children: [
                Expanded(
                  child: isLoading
                      ? const StatsCardSkeleton()
                      : const StatsCard(
                          title: "Total days attended",
                          value: "10/31",
                          icon: Icons.calendar_today,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: isLoading
                      ? const StatsCardSkeleton()
                      : const StatsCard(
                          title: "Last checked-in",
                          value: "09:20 AM",
                          icon: Icons.access_time,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // ProgressRing or its skeleton.
            isLoading
                ? const ProgressRingSkeleton()
                : const ProgressRing(progress: 0.72),
            const SizedBox(height: 16),
            // Dark/Light toggle widget (interactive, no skeleton).
            const ToggleThemeWidget(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavItemTapped,
      ),
    );
  }
}
