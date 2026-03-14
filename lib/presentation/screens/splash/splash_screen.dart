import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/splash/splash_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/splash/splash_event.dart';
import 'package:idoc_admin_side/logic/blocs/splash/splash_state.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/bottom_screen.dart';
import 'package:idoc_admin_side/presentation/screens/auth/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(const StartSplash());

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            if (state.isLoggedIn) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BottomScreen(),
                ),
              );
            } else {
              // User is not logged in, navigate to login screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          double scale = 1.0;
          if (state is SplashAnimating) {
            scale = state.scale;
          }
          return Center(
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/images/idoc_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}