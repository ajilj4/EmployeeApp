// lib/features/dashboard/presentation/widgets/custom_search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_icons.dart';
import '../pages/dashboard_page.dart'; // for searchProvider

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 50, // 🔥 Fixed height
      child: TextField(
        onChanged: (value) => ref.read(searchProvider.notifier).state = value,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
          filled: true,
          fillColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // ✅ zero vertical padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Color(0xFFE8E8E8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Color(0xFFE8E8E8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF006EFF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.search,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
