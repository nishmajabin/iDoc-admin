import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/repositories/application_repository.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_event.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_state.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/widgets/doctor_card.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/widgets/empty_state_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/widgets/error_state_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/widgets/loading_state_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/widgets/snackbar_helper.dart';

class DoctorApplications extends StatelessWidget {
  const DoctorApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ApplicationBloc(repository: ApplicationRepository())
                ..add(LoadApplications()),
      child: const DoctorApplicationsView(),
    );
  }
}

class DoctorApplicationsView extends StatelessWidget {
  const DoctorApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: _buildAppBar(),
        body: BlocConsumer<ApplicationBloc, ApplicationState>(
          listener: (context, state) {
            if (state is ApplicationDeleted) {
              SnackBarHelper.showSuccessSnackBar(context, state.message);
              context.read<ApplicationBloc>().add(LoadApplications());
            } else if (state is ApplicationError) {
              SnackBarHelper.showErrorSnackBar(context, state.message);
            } else if (state is DoctorApproved) {
              context.read<ApplicationBloc>().add(LoadApplications());
            }
          },
          builder: (context, state) {
            if (state is ApplicationLoading) {
              return const LoadingStateWidget();
            }

            if (state is ApplicationsLoaded) {
              if (state.applications.isEmpty) {
                return const EmptyStateWidget();
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ApplicationBloc>().add(LoadApplications());
                },
                color: Colors.blue.shade600,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.applications.length,
                  itemBuilder: (context, index) {
                    final doctor = state.applications[index];
                    return DoctorCard(doctor: doctor);
                  },
                ),
              );
            }

            return ErrorStateWidget(
              onRetry: () {
                context.read<ApplicationBloc>().add(LoadApplications());
              },
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "APPLICATIONS",
        style: GoogleFonts.poppins(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.blue.shade200,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
