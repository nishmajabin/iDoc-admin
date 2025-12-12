import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_state.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/bottom_screen.dart';
import 'package:idoc_admin_side/presentation/screens/auth/widgets/sign_in_forms.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          elevation: 3,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const BottomScreen()),
              );
            } else if (state is AuthError) {
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  Divider(
                    color: primaryColor.withValues(alpha: 0.3),
                    thickness: 1,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.3,
                      vertical: 20,
                    ),
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: LoginForms(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
