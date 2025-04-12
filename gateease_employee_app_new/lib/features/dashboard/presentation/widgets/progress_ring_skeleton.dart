import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProgressRingSkeleton extends StatelessWidget {
  const ProgressRingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Top row placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 14, width: 80, color: baseColor),
                Container(height: 14, width: 14, color: baseColor),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: baseColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
