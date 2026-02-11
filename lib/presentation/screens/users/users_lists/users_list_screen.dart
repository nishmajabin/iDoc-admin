import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_state.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/widgets/user_card.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/widgets/user_list_states.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/widgets/user_search_bar.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/widgets/user_stats_bar.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(repository: UserRepository())..add(const LoadUsers()),
      child: const UsersListView(),
    );
  }
}

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const UserStatsBar(),
          Expanded(child: _buildUsersList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      title: const Text(
        'Users Management',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: primaryColor,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: const UserSearchBar(),
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const UserLoadingState();
        }

        if (state is UserError) {
          return UserErrorState(message: state.message);
        }

        if (state is UserLoaded) {
          if (state.filteredUsers.isEmpty) {
            return UserEmptyState(searchQuery: state.searchQuery);
          }

          return RefreshIndicator(
            color: primaryColor,
            onRefresh: () => _handleRefresh(context),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.filteredUsers.length,
              itemBuilder: (context, index) {
                return UserCard(user: state.filteredUsers[index]);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<UserBloc>().add(const RefreshUsers());
    await Future.delayed(const Duration(seconds: 1));
  }
}