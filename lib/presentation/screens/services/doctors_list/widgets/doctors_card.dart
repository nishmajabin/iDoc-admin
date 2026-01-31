import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'avatar_widget.dart';
import 'doctor_details_dialog.dart';

class DoctorCards extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final String categoryName;

  const DoctorCards({Key? key, required this.doctor, required this.categoryName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = doctor['name'] ?? 'Unknown';
    final String place = doctor['place'] ?? 'Location not specified';
    final String experience = doctor['experience']?.toString() ?? 'N/A';
    final String? profileImageUrl = doctor['profileImageUrl'];
    final String gender = doctor['gender'] ?? 'Not specified';

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
            showDoctorDetailsDialog(context, doctor, categoryName);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: 'doctor_${doctor['email']}',
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
