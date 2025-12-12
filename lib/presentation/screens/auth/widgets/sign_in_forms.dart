import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/core/utils/validators.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_event.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_state.dart';

class LoginForms extends StatelessWidget {
  LoginForms({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _validateFormAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginEvent(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 350,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isPasswordVisible =
                  state is AuthUnauthenticated
                      ? state.isPasswordVisible
                      : state is AuthError
                      ? state.isPasswordVisible
                      : true;

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Username",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Enter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 23,
                          color: primaryColor,
                        ),
                      ),
                      validator: (value) => Validators.nameValidator(value, 'Username'),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              const TogglePasswordVisibilityEvent(),
                            );
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: primaryColor,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 23,
                          color: primaryColor,
                        ),
                        hintText: 'Enter password',
                        labelText: 'Password',
                        labelStyle: TextStyle(color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      validator: Validators.passwordValidator,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 60.0,
                      child:
                          state is AuthLoading
                              ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: ElevatedButton(
                                  onPressed:
                                      () => _validateFormAndLogin(context),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: const BorderSide(
                                        color: Color(0xFF6AD2FF),
                                        width: 3.0,
                                      ),
                                    ),

                                    minimumSize: const Size(100, 0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
