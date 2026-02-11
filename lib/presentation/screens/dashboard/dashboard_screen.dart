import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/dashboard_stat_card.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_event.dart';
import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_state.dart';

import 'widgets/appbar/dashboard_appbar.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/loading_widget.dart';
import 'widgets/error_widget.dart' as custom;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(const FetchAllDataEvent());

    return Scaffold(
      backgroundColor: primaryColor.withValues(alpha: 0.09),
      appBar: const DashboardAppBar(),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const LoadingWidget();
          }

          if (state is DashboardError) {
            return custom.ErrorWidget(
              message: state.message,
              onRetry:
                  () => context.read<DashboardBloc>().add(
                    const FetchAllDataEvent(),
                  ),
            );
          }

          final data =
              state is DashboardLoaded ? state.data : const DashboardData();

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(const FetchAllDataEvent());
              await Future.delayed(const Duration(milliseconds: 500));
            },
            color: const Color.fromARGB(255, 76, 147, 209),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const DashboardHeader(),
                    const SizedBox(height: 30),
                    StatCardWidget(
                      title: 'Doctors',
                      total: data.totalDoctors,
                      male: data.maleDoctors,
                      female: data.femaleDoctors,
                      color: doctorsStatColor,
                      icon: Symbols.stethoscope,
                      imageUrl:
                          'https://media.istockphoto.com/id/147948536/photo/female-doctor-standing-with-arms-crossed-isolated.jpg?s=612x612&w=0&k=20&c=4RZPVLQUuBkP7qDwfpSwlJ8yTQNBqFPI94oJvHSZgvE=',
                      showGenderBreakdown: true, // Show male/female counts
                    ),
                    const SizedBox(height: 28),
                    StatCardWidget(
                      title: 'Patients',
                      total: data.totalPatients,
                      color: patientsStatColor,
                      icon: Icons.people,
                      imageUrl:
                          'https://st2.depositphotos.com/1005435/6561/i/950/depositphotos_65615121-stock-photo-happy-man-isolated-full-body.jpg',
                      showGenderBreakdown: false, // Only show total count
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
