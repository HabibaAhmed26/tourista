import 'package:flutter/material.dart';
import 'package:tourista/core/utils/app_strings.dart';

enum Destinations {
  home(AppStrings.home, Icons.home),
  profile(AppStrings.profile, Icons.person),
  map(AppStrings.map, Icons.map);

  final String name;
  final IconData icon;
  const Destinations(this.name, this.icon);
}
