// lib/data/models/dashboard_data.dart
import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_state.dart';

class DashboardData {
  final int totalDoctors;
  final int maleDoctors;
  final int femaleDoctors;
  final int totalPatients;
  final int malePatients;
  final int femalePatients;

  const DashboardData({
    this.totalDoctors = 0,
    this.maleDoctors = 0,
    this.femaleDoctors = 0,
    this.totalPatients = 0,
    this.malePatients = 0,
    this.femalePatients = 0,
  });

  factory DashboardData.fromState(dynamic state) {
    if (state is DashboardLoaded) {
      return DashboardData(
        totalDoctors: state.data.totalDoctors,
        maleDoctors: state.data.maleDoctors,
        femaleDoctors: state.data.femaleDoctors,
        totalPatients: state.data.totalPatients,
        malePatients: state.data.malePatients,
        femalePatients: state.data.femalePatients,
      );
    }
    return const DashboardData();
  }
}