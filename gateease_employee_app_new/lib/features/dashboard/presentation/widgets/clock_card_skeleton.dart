import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClockCardSkeleton extends StatelessWidget {
  const ClockCardSkeleton({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;
    
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 20, 
          vertical: isSmallScreen ? 16 : 24
        ),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side time placeholder
            Flexible(
              child: Container(
                height: isSmallScreen ? 36 : 48, 
                width: isSmallScreen ? 90 : 120, 
                color: baseColor
              ),
            ),
            
            // Right side column
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Shift info placeholders
                  Container(
                    height: isSmallScreen ? 14 : 16, 
                    width: isSmallScreen ? 150 : 180, 
                    color: baseColor
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: isSmallScreen ? 12 : 14, 
                    width: isSmallScreen ? 80 : 100, 
                    color: baseColor
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 25),
                  
                  // Button placeholder
                  Container(
                    height: 40,
                    width: isSmallScreen ? 100 : 120,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}