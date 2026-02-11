import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key, required this.doctor});

  final DoctorApplicationModel doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: blackColor.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Hero(
                tag: 'doctor_${doctor.id}',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        doctorGradientClr1,
                        doctorGradientClr2,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: blueColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: bgColor,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: doctor.profileImageUrl != null
                          ? NetworkImage(doctor.profileImageUrl!)
                          : null,
                      child: doctor.profileImageUrl == null
                          ? Text(
                              doctor.name[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                doctor.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      doctorGradientClr1,
                      doctorGradientClr2,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  doctor.specialist,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: bgColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "${doctor.bio} • ${doctor.experience} years experience",
                style: TextStyle(
                  fontSize: 15,
                  color: subtitleColor2,
                  height: 1.5, 
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
