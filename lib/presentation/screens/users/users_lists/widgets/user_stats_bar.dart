import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_state.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/widgets/stat_item.dart';

class UserStatsBar extends StatelessWidget {
  const UserStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryColor, gradientColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(
                  icon: Icons.people,
                  label: 'Total Users',
                  value: state.users.length.toString(),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                StatItem(
                  icon: Icons.search,
                  label: 'Results',
                  value: state.filteredUsers.length.toString(),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

