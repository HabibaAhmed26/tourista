import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tourista/core/models/destinations.dart';
import 'package:tourista/core/theme/app_colors.dart';

class NavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: GNav(
            padding: EdgeInsetsGeometry.all(10),
            color: AppColors.white,
            selectedIndex: navigationShell.currentIndex,
            onTabChange: navigationShell.goBranch,
            gap: 8,
            activeColor: Colors.lightBlue.shade200,
            tabBackgroundColor: Colors.grey.shade800,
            tabBorderRadius: 50,

            tabActiveBorder: Border.all(
              color: Colors.black45,
            ), // tab button border

            tabs: Destinations.values
                .map(
                  (distnation) =>
                      GButton(icon: distnation.icon, text: distnation.name),
                )
                .toList(),
          ),
        ),
      ),
      body: navigationShell,
    );
  }
}
