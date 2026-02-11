import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_state.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/approve_button_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/approval_dialog_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/block_unblock_dialog.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/contact_details_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/profile_card_widget.dart';

class ApplicationPreview extends StatelessWidget {
  const ApplicationPreview({super.key, required this.doctor});

  final DoctorApplicationModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: blackColor.withValues(alpha: 0.1), blurRadius: 8),
              ],
            ),
            child: const Icon(Icons.arrow_back, color: blackColor, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (doctor.status == 'approved')
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.more_vert, color: blackColor, size: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'block') {
                  BlockDoctorDialog.show(context, doctor);
                } else if (value == 'unblock') {
                  UnblockDoctorDialog.show(context, doctor);
                }
              },
              itemBuilder: (BuildContext context) => [
                if (!doctor.blocked)
                  PopupMenuItem<String>(
                    value: 'block',
                    child: Row(
                      children: [
                        Icon(
                          Icons.block,
                          size: 20,
                          color: buttonErrorColor,
                        ),
                        const SizedBox(width: 12),
                        const Text('Block Doctor'),
                      ],
                    ),
                  ),
                if (doctor.blocked)
                  PopupMenuItem<String>(
                    value: 'unblock',
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: scaffoldSuccessColor,
                        ),
                        const SizedBox(width: 12),
                        const Text('Unblock Doctor'),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
      body: BlocConsumer<ApplicationBloc, ApplicationState>(
        listener: (context, state) {
          if (state is DoctorApproved) {
            _showSuccessSnackBar(context, state.message);
            Navigator.of(context).pop();
          } else if (state is DoctorBlocked) {
            _showErrorSnackBar(context, state.message);
            Navigator.of(context).pop();
          } else if (state is DoctorUnblocked) {
            _showSuccessSnackBar(context, state.message);
            Navigator.of(context).pop();
          } else if (state is ApplicationError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is ApplicationLoading;

          return Stack(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [buttonBorderColor, doctorGradientClr2],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    ProfileCardWidget(doctor: doctor),
                    const SizedBox(height: 24),
                    ContactDetailsWidget(doctor: doctor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ApproveButtonWidget(
                            isLoading: isLoading,
                            onPressed: doctor.status == 'pending'
                                ? () => _showApprovalDialog(context)
                                : null,
                            isApproved: doctor.status == 'approved',
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: bgColor),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: scaffoldSuccessColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: bgColor),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: buttonErrorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showApprovalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ApprovalDialogWidget(
          doctorId: doctor.id!,
          doctorName: doctor.name,
        );
      },
    );
  }
}