import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';

class UserLoadingState extends StatelessWidget {
  const UserLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: primaryColor),
    );
  }
}

class UserErrorState extends StatelessWidget {
  final String message;

  const UserErrorState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.read<UserBloc>().add(const LoadUsers());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserEmptyState extends StatelessWidget {
  final String? searchQuery;

  const UserEmptyState({
    super.key,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: subtitleColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery != null && searchQuery!.isNotEmpty
                ? 'No users found'
                : 'No users yet',
            style: TextStyle(
              color: subtitleColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}