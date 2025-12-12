import 'package:flutter/material.dart';
import 'avatar_widget.dart';
import 'detail_row_widget.dart';
import 'license_section_widget.dart';

void showDoctorDetailsDialog(
  BuildContext context,
  Map<String, dynamic> doctor,
  String categoryName,
) {
  final String name = doctor['name'] ?? 'Unknown';
  final String place = doctor['place'] ?? 'Location not specified';
  final String experience = doctor['experience']?.toString() ?? 'N/A';
  final String phone = doctor['phone'] ?? 'N/A';
  final String email = doctor['email'] ?? 'N/A';
  final String bio = doctor['bio'] ?? 'No bio available';
  final String licenseNumber = doctor['licenseNumber'] ?? 'N/A';
  final String? profileImageUrl = doctor['profileImageUrl'];
  final String? licenseFileUrl = doctor['licenseFileUrl'];
  final String gender = doctor['gender'] ?? 'Not specified';

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'doctor_${doctor['email']}',
                  child: AvatarWidget(
                    profileImageUrl: profileImageUrl,
                    name: name,
                    gender: gender,
                    size: 120,
                    isCircular: true,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dr. $name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6FCA78).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6FCA78),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                DetailRowWidget(
                  icon: Icons.work_outline,
                  label: 'Experience',
                  value: '$experience years',
                ),
                DetailRowWidget(
                  icon: Icons.badge_outlined,
                  label: 'License',
                  value: licenseNumber,
                ),
                DetailRowWidget(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: place,
                ),
                DetailRowWidget(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: phone,
                ),
                DetailRowWidget(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: email,
                ),
                DetailRowWidget(
                  icon: Icons.person_outline,
                  label: 'Gender',
                  value: gender,
                ),
                if (licenseFileUrl != null && licenseFileUrl.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  LicenseSectionWidget(licenseFileUrl: licenseFileUrl),
                ],
                const SizedBox(height: 16),
                _buildBioSection(bio),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6FCA78),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildBioSection(String bio) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 20,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              'Bio',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          bio,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
