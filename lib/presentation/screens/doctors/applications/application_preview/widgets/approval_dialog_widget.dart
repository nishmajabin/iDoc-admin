import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_event.dart';

class ApprovalDialogWidget extends StatelessWidget {
  const ApprovalDialogWidget({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  final String doctorId;
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.check_circle_outline, color: scaffoldSuccessColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text("Confirm Approval", overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to approve $doctorName's application?",
        style: const TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel", style: TextStyle(color: unselectedColor)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<ApplicationBloc>().add(ApproveDoctor(doctorId));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: scaffoldSuccessColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Approve", style: TextStyle(color: bgColor)),
        ),
      ],
    );
  }
}
