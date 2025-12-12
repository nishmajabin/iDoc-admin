import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/widgets/side_nav_item.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/widgets/bottom_nav_item.dart';

class NavItemsList {
  static const List<NavItemData> items = [
    NavItemData(icon: Icons.dashboard_outlined, label: 'Dashboard', index: 0),
    NavItemData(icon: Icons.people_outline, label: 'Users', index: 1),
    NavItemData(icon: Symbols.stethoscope, label: 'Doctors', index: 2),
    NavItemData(icon: Icons.medical_services, label: 'Services', index: 3),
  ];

  static List<Widget> buildSideNavItems({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return items.map((item) {
      return SideNavItem(
        icon: item.icon,
        label: item.label,
        index: item.index,
        isSelected: currentIndex == item.index,
        onTap: () => onTap(item.index),
      );
    }).toList();
  }

  static List<Widget> buildBottomNavItems({
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return items.map((item) {
      return BottomNavItem(
        icon: item.icon,
        label: item.label,
        index: item.index,
        isSelected: currentIndex == item.index,
        onTap: () => onTap(item.index),
      );
    }).toList();
  }
}

class NavItemData {
  final IconData icon;
  final String label;
  final int index;

  const NavItemData({
    required this.icon,
    required this.label,
    required this.index,
  });
}
