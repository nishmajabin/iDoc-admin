abstract class DoctorsEvent {}

class LoadDoctorsEvent extends DoctorsEvent {}

class LoadPendingDoctorsEvent extends DoctorsEvent {}

class LoadApprovedDoctorsEvent extends DoctorsEvent {}

class ApproveDoctorEvent extends DoctorsEvent {
  final String doctorId;

  ApproveDoctorEvent(this.doctorId);
}

class RejectDoctorEvent extends DoctorsEvent {
  final String doctorId;
  final String? reason;

  RejectDoctorEvent(this.doctorId, {this.reason});
}


