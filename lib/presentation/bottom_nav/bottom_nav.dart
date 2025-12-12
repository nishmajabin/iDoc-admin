import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:idoc_admin_side/presentation/bottom_nav/widgets/user_profile_section.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/widgets/logout_button.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/widgets/nav_items_list.dart';

class AdminBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final VoidCallback? onLogout;

  const AdminBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb && MediaQuery.of(context).size.width >= 600;
    return isDesktop ? _buildSideNavigation() : _buildBottomNavigation();
  }

  Widget _buildSideNavigation() {
    return Container(
      width: 280,
      decoration: const BoxDecoration(color: Color(0xFF255267)),
      child: Column(
        children: [
          const UserProfileSection(),
          const Divider(height: 1, color: Colors.white24, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: NavItemsList.buildSideNavItems(
                currentIndex: currentIndex,
                onTap: (index) => onTap?.call(index),
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.white24, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: LogoutButton(onLogout: onLogout),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavItemsList.buildBottomNavItems(
          currentIndex: currentIndex,
          onTap: (index) => onTap?.call(index),
        ),
      ),
    );
  }
}
