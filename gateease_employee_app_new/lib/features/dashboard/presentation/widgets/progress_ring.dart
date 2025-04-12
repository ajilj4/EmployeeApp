import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;

  const ProgressRing({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.black54;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Title & Dropdown icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This month',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: subTextColor),
            ],
          ),
          const SizedBox(height: 20),

          // Circular Progress
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
