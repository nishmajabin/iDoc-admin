import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_event.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_state.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/appbar/logout_dialog_content.dart';

class LogoutDialog extends StatelessWidget {
  final BuildContext parentContext;

  const LogoutDialog({
    super.key,
    required this.parentContext,
  });

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(parentContext).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: backgroundColor == Colors.red ? 3 : 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pop();
          _showSnackBar(state.message, const Color(0xFF6FCA78));
        } else if (state is LogoutFailure) {
          Navigator.of(context).pop();
          _showSnackBar(state.error, Colors.red);
        }
      },
      builder: (context, state) {
        final isLoading = state is LogoutLoading;
        
        return WillPopScope(
          onWillPop: () async => !isLoading,
          child: LogoutDialogContent(
            isLoading: isLoading,
            onCancel: () => Navigator.of(context).pop(),
            onConfirm: () => context.read<LogoutBloc>().add(
                  const LogoutRequested(),
                ),
          ),
        );
      },
    );
  }
}