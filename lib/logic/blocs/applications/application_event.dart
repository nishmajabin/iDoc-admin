// import 'package:equatable/equatable.dart';
// import 'package:idoc_admin_side/data/models/application_model.dart';

// abstract class ApplicationEvent extends Equatable {
//   const ApplicationEvent();

//   @override
//   List<Object?> get props => [];
// }

// // Load applications
// class LoadApplications extends ApplicationEvent {}

// // Select an application for viewing
// class SelectApplication extends ApplicationEvent {
//   final DoctorApplicationModel application;

//   const SelectApplication({required this.application});

//   @override
//   List<Object?> get props => [application];
// }

// // Delete an application
// class DeleteApplication extends ApplicationEvent {
//   final String docId;

//   const DeleteApplication({required this.docId});

//   @override
//   List<Object?> get props => [docId];
// }

// // Approve doctor (simple - no password needed)
// class ApproveDoctor extends ApplicationEvent {
//   final String docId;

//   const ApproveDoctor({required this.docId});

//   @override
//   List<Object?> get props => [docId];
// }

import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object?> get props => [];
}

class LoadApplications extends ApplicationEvent {}

class SelectApplication extends ApplicationEvent {
  final DoctorApplicationModel application;

  const SelectApplication(this.application);

  @override
  List<Object?> get props => [application];
}

class DeleteApplication extends ApplicationEvent {
  final String docId;

  const DeleteApplication(this.docId);

  @override
  List<Object?> get props => [docId];
}

class ApproveDoctor extends ApplicationEvent {
  final String docId;

  const ApproveDoctor(this.docId);

  @override
  List<Object?> get props => [docId];
}

class BlockDoctor extends ApplicationEvent {
  final String docId;
  final String? reason;

  const BlockDoctor({
    required this.docId,
    this.reason,
  });

  @override
  List<Object?> get props => [docId, reason];
}

class UnblockDoctor extends ApplicationEvent {
  final String docId;

  const UnblockDoctor(this.docId);

  @override
  List<Object?> get props => [docId];
}