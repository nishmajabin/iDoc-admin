import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_event.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_state.dart';

class SideNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const SideNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavHoverBloc, NavHoverState>(
      builder: (context, hoverState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter:
              (_) => context.read<NavHoverBloc>().add(NavHoverEntered(index)),
          onExit:
              (_) => context.read<NavHoverBloc>().add(NavHoverExited(index)),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              margin: const EdgeInsets.only(left: 10, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFFE8EAF6) : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color:
                        isSelected
                            ? primaryColor
                            : Colors.white.withValues(alpha: 0.7),
                    size: 22,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: TextStyle(
                      color:
                          isSelected
                              ? primaryColor
                              : Colors.white.withValues(alpha: 0.9),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
