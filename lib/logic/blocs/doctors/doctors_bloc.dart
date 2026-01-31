// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idoc_admin_side/data/repositories/doctor_repository.dart';
// import 'package:idoc_admin_side/logic/blocs/doctors/doctors_event.dart';
// import 'package:idoc_admin_side/logic/blocs/doctors/doctors_state.dart';

// class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
//   final DoctorRepository _repository = DoctorRepository();

//   DoctorsBloc() : super(DoctorsInitialState()) {
//     on<LoadDoctorsEvent>(_onLoadDoctors);
//     on<LoadPendingDoctorsEvent>(_onLoadPendingDoctors);
//     on<LoadApprovedDoctorsEvent>(_onLoadApprovedDoctors);
//     on<ApproveDoctorEvent>(_onApproveDoctor);
//     on<RejectDoctorEvent>(_onRejectDoctor);
//   }

//   void _onLoadDoctors(
//     LoadDoctorsEvent event,
//     Emitter<DoctorsState> emit,
//   ) {
//     emit(DoctorsLoadingState());
//     _repository.getAllDoctors().listen(
//       (doctors) {
//         emit(DoctorsLoadedState(doctors));
//       },
//       onError: (error) {
//         emit(DoctorsErrorState(error.toString()));
//       },
//     );
//   }

//   void _onLoadPendingDoctors(
//     LoadPendingDoctorsEvent event,
//     Emitter<DoctorsState> emit,
//   ) {
//     emit(DoctorsLoadingState());
//     _repository.getPendingDoctors().listen(
//       (doctors) {
//         emit(DoctorsLoadedState(doctors));
//       },
//       onError: (error) {
//         emit(DoctorsErrorState(error.toString()));
//       },
//     );
//   }

//   void _onLoadApprovedDoctors(
//     LoadApprovedDoctorsEvent event,
//     Emitter<DoctorsState> emit,
//   ) {
//     emit(DoctorsLoadingState());
//     _repository.getApprovedDoctors().listen(
//       (doctors) {
//         emit(DoctorsLoadedState(doctors));
//       },
//       onError: (error) {
//         emit(DoctorsErrorState(error.toString()));
//       },
//     );
//   }

//   Future<void> _onApproveDoctor(
//     ApproveDoctorEvent event,
//     Emitter<DoctorsState> emit,
//   ) async {
//     emit(DoctorApprovingState(event.doctorId));
//     try {
//       await _repository.approveDoctor(event.doctorId);
//       emit(DoctorApprovedState('Doctor approved successfully'));
//       // Reload pending doctors
//       add(LoadPendingDoctorsEvent());
//     } catch (e) {
//       emit(DoctorsErrorState('Failed to approve doctor: $e'));
//     }
//   }

//   Future<void> _onRejectDoctor(
//     RejectDoctorEvent event,
//     Emitter<DoctorsState> emit,
//   ) async {
//     emit(DoctorRejectingState(event.doctorId));
//     try {
//       await _repository.rejectDoctor(event.doctorId, reason: event.reason);
//       emit(DoctorRejectedState('Doctor rejected successfully'));
//       // Reload pending doctors
//       add(LoadPendingDoctorsEvent());
//     } catch (e) {
//       emit(DoctorsErrorState('Failed to reject doctor: $e'));
//     }
//   }
// }





