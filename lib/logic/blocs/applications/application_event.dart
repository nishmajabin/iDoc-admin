import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object?> get props => [];
}

// Load applications
class LoadApplications extends ApplicationEvent {}

// Select an application for viewing
class SelectApplication extends ApplicationEvent {
  final DoctorApplicationModel application;

  const SelectApplication({required this.application});

  @override
  List<Object?> get props => [application];
}

// Delete an application
class DeleteApplication extends ApplicationEvent {
  final String docId;

  const DeleteApplication({required this.docId});

  @override
  List<Object?> get props => [docId];
}

// Approve doctor (simple - no password needed)
class ApproveDoctor extends ApplicationEvent {
  final String docId;

  const ApproveDoctor({required this.docId});

  @override
  List<Object?> get props => [docId];
}