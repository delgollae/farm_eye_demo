import 'package:flutter/material.dart';

class DrawerItem {
  DrawerItem({
    required this.title,
    required this.prefix,
    required this.onTap,
  });

  final String title;
  final Widget prefix;
  final VoidCallback onTap;
}