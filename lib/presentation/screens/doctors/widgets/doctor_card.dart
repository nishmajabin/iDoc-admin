import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_event.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/application_preview.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/widgets/doctor_avatar_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/widgets/modern_button_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/widgets/reject_dialog_widget.dart';

class DoctorCard extends StatelessWidget {
  final DoctorApplicationModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bgColor, boxColor.withValues(alpha: 0.3)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: blueColor.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.1), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DoctorAvatarWidget(doctor: doctor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [gradientColor, Colors.blue.shade600],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            doctor.specialist,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.medical_information_outlined,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "License: ${doctor.licenseNumber}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ModernButtonWidget(
                      label: "View Details",
                      icon: Icons.visibility_outlined,
                      isPrimary: true,
                      onPressed: () {
                        context.read<ApplicationBloc>().add(
                          SelectApplication(doctor),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider.value(
                                  value: context.read<ApplicationBloc>(),
                                  child: ApplicationPreview(doctor: doctor),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ModernButtonWidget(
                      label: "Reject",
                      icon: Icons.close_rounded,
                      isPrimary: false,
                      onPressed: () => _showRejectDialog(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return RejectDialogWidget(
          doctorId: doctor.id!,
          doctorName: doctor.name,
        );
      },
    );
  }
}
