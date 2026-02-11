import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/application_preview.dart';
import 'avatar_widget.dart';

class DoctorCards extends StatelessWidget {
  final String categoryName;
  final DoctorApplicationModel doctorApplication;

  const DoctorCards({
    Key? key,
    required this.categoryName,
    required this.doctorApplication
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = doctorApplication.name;
    final String place = doctorApplication.place;
    final String experience = doctorApplication.experience.toString();
    final String? profileImageUrl = doctorApplication.profileImageUrl;
    final String gender = doctorApplication.gender;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider.value(
                      value: context.read<ApplicationBloc>(),
                      child: ApplicationPreview(doctor: doctorApplication),
                    ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: 'doctor_${doctorApplication.email}',
                  child: AvatarWidget(
                    profileImageUrl: profileImageUrl,
                    name: name,
                    gender: gender,
                    size: 80,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. $name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: locationColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              place,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: subtitleColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6FCA78).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.work_outline,
                              size: 14,
                              color: Color(0xFF6FCA78),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$experience years exp.',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6FCA78),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6FCA78).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF6FCA78),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
