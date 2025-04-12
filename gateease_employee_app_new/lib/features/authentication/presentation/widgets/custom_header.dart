import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_icons.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/app_routes.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? svgImage;

  const CustomHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.svgImage,
  });

  @override
  Widget build(BuildContext context) {

        final String currentRoute = GoRouterState.of(context).uri.path;
   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        IconButton(
          icon: SvgPicture.asset(AppIcons.backArrow),
          onPressed: () {
            if (currentRoute == AppRoutes.login) {
              context.go(AppRoutes.onboarding); 
            } else if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.login);
            }
          },
          tooltip: "Back",
        ),
        const SizedBox(height: 30),
        if (svgImage != null)
          Center(
            child: SvgPicture.asset(svgImage!), // Adjusted to Figma
          ),
        const SizedBox(height: 30),
        Text(title, style: AppTextStyles.heading),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: AppTextStyles.subtitle),
        ],
      ],
    );
  }
}
