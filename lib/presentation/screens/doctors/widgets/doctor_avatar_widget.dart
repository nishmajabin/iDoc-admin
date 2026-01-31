import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

class DoctorAvatarWidget extends StatelessWidget {
  const DoctorAvatarWidget({super.key, required this.doctor});

  final DoctorApplicationModel doctor;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'doctor_${doctor.id}',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.purple.shade400],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 32,
            backgroundImage:
                doctor.profileImageUrl != null
                    ? NetworkImage(doctor.profileImageUrl!)
                    : null,
            child:
                doctor.profileImageUrl == null
                    ? Text(
                      doctor.name[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
