import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_bloc.dart';import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/appbar/app_bar_logo.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/appbar/logout_button.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/appbar/logout_dialog.dart';


class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<LogoutBloc>(),
        child: LogoutDialog(parentContext: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const AppBarLogo(),
      actions: [
        LogoutButton(onPressed: () => _showLogoutDialog(context)),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
    );
  }
}