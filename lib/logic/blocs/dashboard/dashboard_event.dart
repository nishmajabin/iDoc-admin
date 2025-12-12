import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDoctorsEvent extends DashboardEvent {
  const FetchDoctorsEvent();
}

class FetchPatientsEvent extends DashboardEvent {
  const FetchPatientsEvent();
}

class FetchAllDataEvent extends DashboardEvent {
  const FetchAllDataEvent();
}