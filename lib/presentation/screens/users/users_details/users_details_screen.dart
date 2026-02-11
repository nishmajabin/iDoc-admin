import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_state.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/account_info_card.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/contact_info_card.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/user_detail_sliver_appbar.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/user_info_card.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(repository: UserRepository())..add(LoadUserDetails(userId)),
      child: const UserDetailView(),
    );
  }
}

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<UserBloc, UserState>(
        listener: _handleStateChanges,
        builder: _buildContent,
      ),
    );
  }

  void _handleStateChanges(BuildContext context, UserState state) {
    if (state is UserStatusUpdated) {
      _showSnackBar(
        context,
        message: 'User status updated successfully',
        backgroundColor: successColor,
      );
    }
    if (state is UserDetailError) {
      _showSnackBar(
        context,
        message: state.message,
        backgroundColor: errorBgColor,
      );
    }
  }

  void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, UserState state) {
    if (state is UserDetailLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    if (state is UserDetailError) {
      return _buildErrorView(context, state.message);
    }

    if (state is UserDetailLoaded || state is UserStatusUpdated) {
      final user = state is UserDetailLoaded
          ? state.user
          : (state as UserStatusUpdated).user;
      return _buildUserDetail(user);
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: errorOutlineColor,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: errorTextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetail(UserModel user) {
    return CustomScrollView(
      slivers: [
        UserDetailSliverAppBar(user: user),
        SliverToBoxAdapter(
          child: Column(
            children: [
              UserInfoCard(user: user),
              ContactInfoCard(user: user),
              AccountInfoCard(user: user),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }
}