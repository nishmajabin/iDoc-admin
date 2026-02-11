// import 'package:equatable/equatable.dart';
// import 'package:idoc_admin_side/data/models/application_model.dart';

// abstract class ApplicationState extends Equatable {
//   const ApplicationState();

//   @override
//   List<Object?> get props => [];
// }

// // Initial state
// class ApplicationInitial extends ApplicationState {}

// // Loading state
// class ApplicationLoading extends ApplicationState {}

// // Applications loaded successfully
// class ApplicationsLoaded extends ApplicationState {
//   final List<DoctorApplicationModel> applications;

//   const ApplicationsLoaded({required this.applications});

//   @override
//   List<Object?> get props => [applications];
// }

// // Application selected for viewing
// class ApplicationSelected extends ApplicationState {
//   final DoctorApplicationModel application;

//   const ApplicationSelected({required this.application});

//   @override
//   List<Object?> get props => [application];
// }

// // Application deleted successfully
// class ApplicationDeleted extends ApplicationState {
//   final String message;

//   const ApplicationDeleted({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

// // Doctor approved successfully
// class DoctorApproved extends ApplicationState {
//   final String message;

//   const DoctorApproved({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

// // Error state
// class ApplicationError extends ApplicationState {
//   final String message;

//   const ApplicationError({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

abstract class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object?> get props => [];
}

class ApplicationInitial extends ApplicationState {}

class ApplicationLoading extends ApplicationState {}

class ApplicationsLoaded extends ApplicationState {
  final List<DoctorApplicationModel> applications;

  const ApplicationsLoaded({required this.applications});

  @override
  List<Object?> get props => [applications];
}

class ApplicationSelected extends ApplicationState {
  final DoctorApplicationModel application;

  const ApplicationSelected({required this.application});

  @override
  List<Object?> get props => [application];
}

class ApplicationDeleted extends ApplicationState {
  final String message;

  const ApplicationDeleted({required this.message});

  @override
  List<Object?> get props => [message];
}

class DoctorApproved extends ApplicationState {
  final String message;

  const DoctorApproved({required this.message});

  @override
  List<Object?> get props => [message];
}

class DoctorBlocked extends ApplicationState {
  final String message;

  const DoctorBlocked({required this.message});

  @override
  List<Object?> get props => [message];
}

class DoctorUnblocked extends ApplicationState {
  final String message;

  const DoctorUnblocked({required this.message});

  @override
  List<Object?> get props => [message];
}

class ApplicationError extends ApplicationState {
  final String message;

  const ApplicationError({required this.message});

  @override
  List<Object?> get props => [message];
}