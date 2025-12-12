import 'package:equatable/equatable.dart';

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

  DashboardData copyWith({
    int? totalDoctors,
    int? maleDoctors,
    int? femaleDoctors,
    int? totalPatients,
    int? malePatients,
    int? femalePatients,
  }) {
    return DashboardData(
      totalDoctors: totalDoctors ?? this.totalDoctors,
      maleDoctors: maleDoctors ?? this.maleDoctors,
      femaleDoctors: femaleDoctors ?? this.femaleDoctors,
      totalPatients: totalPatients ?? this.totalPatients,
      malePatients: malePatients ?? this.malePatients,
      femalePatients: femalePatients ?? this.femalePatients,
    );
  }
}

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardData data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}