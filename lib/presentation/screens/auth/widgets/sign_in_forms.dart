import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_event.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_state.dart';
import 'package:idoc_admin_side/presentation/screens/auth/widgets/login_text_field.dart';
import 'package:idoc_admin_side/presentation/screens/auth/widgets/login_button.dart';
import 'package:idoc_admin_side/presentation/screens/auth/widgets/field_label.dart';

class LoginForms extends StatelessWidget {
  LoginForms({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void _handleLogin(BuildContext context, String username, String password) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
            username: username,
            password: password,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const FieldLabel(text: "Username"),
                const SizedBox(height: 10),
                LoginTextField(
                  key: const ValueKey('username_field'),
                  initialValue: state.username,
                  hintText: 'Enter username',
                  icon: Icons.email,
                  fieldType: TextFieldType.username,
                  onChanged: (value) => context
                      .read<AuthBloc>()
                      .add(UpdateUsernameEvent(value)),
                ),
                const SizedBox(height: 30),
                const FieldLabel(text: "Password"),
                const SizedBox(height: 10),
                LoginTextField(
                  key: const ValueKey('password_field'),
                  initialValue: state.password,
                  hintText: 'Enter password',
                  icon: Icons.lock,
                  fieldType: TextFieldType.password,
                  isPasswordVisible: state.isPasswordVisible,
                  onChanged: (value) => context
                      .read<AuthBloc>()
                      .add(UpdatePasswordEvent(value)),
                  onFieldSubmitted: (_) =>
                      _handleLogin(context, state.username, state.password),
                  onToggleVisibility: () => context
                      .read<AuthBloc>()
                      .add(const TogglePasswordVisibilityEvent()),
                ),
                const SizedBox(height: 50),
                LoginButton(
                  isLoading: state is AuthLoading,
                  onPressed: () =>
                      _handleLogin(context, state.username, state.password),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}