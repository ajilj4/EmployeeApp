// lib/features/dashboard/presentation/widgets/toggle_theme_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import the themeModeProvider from your main.dart file.
import 'package:gateease_employee_app_new/main.dart';

class ToggleThemeWidget extends ConsumerWidget {
  const ToggleThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wb_sunny, color: isDarkMode ? Colors.grey : Colors.orange),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            ref.read(themeModeProvider.notifier).state =
                value ? ThemeMode.dark : ThemeMode.light;
          },
        ),
        Icon(Icons.nightlight_round, color: isDarkMode ? Colors.amber : Colors.grey),
      ],
    );
  }
}
