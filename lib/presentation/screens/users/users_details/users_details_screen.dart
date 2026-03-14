import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/user_detail_view.dart';

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

