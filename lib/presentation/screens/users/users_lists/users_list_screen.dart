import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_lists/users_list_view.dart';

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

