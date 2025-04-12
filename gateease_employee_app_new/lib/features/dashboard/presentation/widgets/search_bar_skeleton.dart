// lib/features/dashboard/presentation/widgets/search_bar_skeleton.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchBarSkeleton extends StatelessWidget {
  const SearchBarSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade600 : Colors.grey.shade100,
      child: Container(
        height: 50, // Match the height of your actual search bar.
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 16,
                color: Colors.transparent,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.all(8),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
