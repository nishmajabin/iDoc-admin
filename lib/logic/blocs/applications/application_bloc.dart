import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/data/repositories/application_repository.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepository repository;
  StreamSubscription<List<DoctorApplicationModel>>? _applicationsSubscription;

  ApplicationBloc({required this.repository}) : super(ApplicationInitial()) {
    on<LoadApplications>(_onLoadApplications);
    on<SelectApplication>(_onSelectApplication);
    on<DeleteApplication>(_onDeleteApplication);
    on<ApproveDoctor>(_onApproveDoctor);
    on<_ApplicationsUpdated>(_onApplicationsUpdated);
  }

  Future<void> _onLoadApplications(
    LoadApplications event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(ApplicationLoading());
    
    await _applicationsSubscription?.cancel();
    
    _applicationsSubscription = repository.getDoctorApplicationsStream().listen(
      (applications) {
        add(_ApplicationsUpdated(applications));
      },
      onError: (error) {
        emit(ApplicationError(message: error.toString()));
      },
    );
  }

  Future<void> _onApplicationsUpdated(
    _ApplicationsUpdated event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(ApplicationsLoaded(applications: event.applications));
  }

  Future<void> _onSelectApplication(
    SelectApplication event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(ApplicationSelected(application: event.application));
  }

  Future<void> _onDeleteApplication(
    DeleteApplication event,
    Emitter<ApplicationState> emit,
  ) async {
    try {
      emit(ApplicationLoading());
      await repository.deleteApplication(event.docId);
      emit(const ApplicationDeleted(message: 'Application removed successfully'));
      
      // Reload applications
      add(LoadApplications());
    } catch (e) {
      emit(ApplicationError(message: e.toString()));
    }
  }

  Future<void> _onApproveDoctor(
    ApproveDoctor event,
    Emitter<ApplicationState> emit,
  ) async {
    try {
      emit(ApplicationLoading());
      
      // Simply approve the doctor by updating status
      await repository.approveDoctor(event.docId);
      
      emit(const DoctorApproved(message: 'Doctor approved successfully'));
      
      // Reload applications to reflect changes
      add(LoadApplications());
    } catch (e) {
      emit(ApplicationError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _applicationsSubscription?.cancel();
    return super.close();
  }
}

// Internal event for stream updates
class _ApplicationsUpdated extends ApplicationEvent {
  final List<DoctorApplicationModel> applications;

  const _ApplicationsUpdated(this.applications);

  @override
  List<Object?> get props => [applications];
}