import 'package:flutter/material.dart';
import 'package:tourista/core/utils/app_strings.dart';

enum Destinations {
  home(AppStrings.home, Icon(Icons.home)),
  profile(AppStrings.profile, Icon(Icons.person)),
  map(AppStrings.map, Icon(Icons.map));

  final String name;
  final Icon icon;
  const Destinations(this.name, this.icon);
}
