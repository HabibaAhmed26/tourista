import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourista/core/models/destinations.dart';
import 'package:tourista/core/theme/app_colors.dart';

class NavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: AppColors.darkBlue,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        destinations: Destinations.values
            .map(
              (distnation) => NavigationDestination(
                icon: distnation.icon,
                label: distnation.name,
              ),
            )
            .toList(),
      ),
      body: navigationShell,
    );
  }
}
