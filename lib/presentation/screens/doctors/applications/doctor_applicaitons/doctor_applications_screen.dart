import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/repositories/application_repository.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_event.dart';

import 'package:idoc_admin_side/presentation/screens/doctors/applications/doctor_applicaitons/doctor_application_view.dart';

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
