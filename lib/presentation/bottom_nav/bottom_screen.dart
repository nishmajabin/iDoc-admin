import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_event.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_state.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_event.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_state.dart';
import 'package:idoc_admin_side/presentation/bottom_nav/bottom_nav.dart';
import 'package:idoc_admin_side/presentation/screens/auth/sign_in_screen.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/doctor_applications_screen.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/add_services_screen.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_screen.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = isWeb && screenWidth >= 600;

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          try {
            context.read<BottomNavBloc>().add(const BottomNavReset());
          } catch (e) {
            throw Exception('BottomNavBloc reset error: $e');
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            }
          });
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          if (isDesktop) {
            // Web/Desktop Layout with Side Navigation
            return Scaffold(
              backgroundColor: const Color(0xFFE6EFF9),
              body: Row(
                children: [
                  AdminBottomNavBar(
                    currentIndex: state.currentIndex,
                    onTap: (index) {
                      context.read<BottomNavBloc>().add(BottomNavTabChanged(index));
                    },
                    onLogout: () {
                      context.read<LogoutBloc>().add(LogoutRequested());
                    },
                  ),
                  Expanded(
                    child: Container(
                      constraints: isWeb
                          ? const BoxConstraints(maxWidth: 1400)
                          : const BoxConstraints(),
                      margin: isWeb
                          ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
                          : EdgeInsets.zero,
                      child: _buildBody(state.currentIndex),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Mobile Layout with Bottom Navigation
            return Scaffold(
              backgroundColor: const Color(0xFFE6EFF9),
              body: _buildBody(state.currentIndex),
              bottomNavigationBar: AdminBottomNavBar(
                currentIndex: state.currentIndex,
                onTap: (index) {
                  context.read<BottomNavBloc>().add(BottomNavTabChanged(index));
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const UsersScreen();
      case 2:
        return const DoctorApplications();
      case 3:
        return  AddServicesScreen();
      default:
        return const DashboardScreen();
    }
  }
}