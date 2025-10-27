import 'package:flutter/material.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/core/utils/app_assets.dart';

class PatternContainer extends StatelessWidget {
  final Widget child;
  const PatternContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(AppAssets.pattern).image,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
