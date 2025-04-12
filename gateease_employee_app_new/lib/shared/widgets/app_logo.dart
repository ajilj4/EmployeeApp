import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/logo.svg", // ✅ Updated for SVG
      height: size,
    );
  }
}
