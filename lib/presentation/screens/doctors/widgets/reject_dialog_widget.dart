import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_event.dart';

class RejectDialogWidget extends StatelessWidget {
  const RejectDialogWidget({
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
          Icon(Icons.warning_amber_rounded, color: alertBoxColor),
          const SizedBox(width: 12),
          const Expanded(
            child: Text("Confirm Rejection", overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to reject this application from $doctorName?",
        style: const TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel", style: TextStyle(color: unselectedColor)),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ApplicationBloc>().add(
              DeleteApplication( doctorId),
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: errorOutlineColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Reject"),
        ),
      ],
    );
  }
}
