import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(const DashboardInitial()) {
    on<FetchDoctorsEvent>(_onFetchDoctors);
    on<FetchPatientsEvent>(_onFetchPatients);
    on<FetchAllDataEvent>(_onFetchAllData);
  }

  Future<void> _onFetchDoctors(
    FetchDoctorsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final doctors = await repository.fetchDoctors();
      final genderCount = repository.countByGender(doctors);
      
      final currentData = state is DashboardLoaded
          ? (state as DashboardLoaded).data
          : const DashboardData();

      emit(DashboardLoaded(
        currentData.copyWith(
          totalDoctors: doctors.length,
          maleDoctors: genderCount['male']!,
          femaleDoctors: genderCount['female']!,
        ),
      ));
    } catch (e) {
      emit(DashboardError('Failed to fetch doctors: ${e.toString()}'));
    }
  }

  Future<void> _onFetchPatients(
    FetchPatientsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final patients = await repository.fetchPatients();
      final genderCount = repository.countByGender(patients);
      
      final currentData = state is DashboardLoaded
          ? (state as DashboardLoaded).data
          : const DashboardData();

      emit(DashboardLoaded(
        currentData.copyWith(
          totalPatients: patients.length,
          malePatients: genderCount['male']!,
          femalePatients: genderCount['female']!,
        ),
      ));
    } catch (e) {
      emit(DashboardError('Failed to fetch patients: ${e.toString()}'));
    }
  }

  Future<void> _onFetchAllData(
    FetchAllDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());

    try {
      final results = await Future.wait([
        repository.fetchDoctors(),
        repository.fetchPatients(),
      ]);

      final doctors = results[0];
      final patients = results[1];
      
      final doctorGenderCount = repository.countByGender(doctors);
      final patientGenderCount = repository.countByGender(patients);

      emit(DashboardLoaded(DashboardData(
        totalDoctors: doctors.length,
        maleDoctors: doctorGenderCount['male']!,
        femaleDoctors: doctorGenderCount['female']!,
        totalPatients: patients.length,
        malePatients: patientGenderCount['male']!,
        femalePatients: patientGenderCount['female']!,
      )));
    } catch (e) {
      emit(DashboardError('Failed to fetch data: ${e.toString()}'));
    }
  }
}