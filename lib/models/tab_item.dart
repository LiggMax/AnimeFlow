import 'package:flutter/material.dart';

enum TabType {
  home,
  category,
  cart,
  profile
}

class TabItem {
  final TabType type;
  final String title;
  final IconData icon;
  final IconData activeIcon;

  TabItem({
    required this.type,
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}