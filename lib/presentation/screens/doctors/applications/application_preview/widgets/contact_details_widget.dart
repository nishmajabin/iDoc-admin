import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/certificate_button_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/application_preview/widgets/info_card_widget.dart';

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget({super.key, required this.doctor});

  final DoctorApplicationModel doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Information",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          InfoCardWidget(
            icon: Icons.email_outlined,
            label: "Email",
            value: doctor.email,
            color: blueColor,
          ),
          InfoCardWidget(
            icon: Icons.phone_outlined,
            label: "Phone",
            value: doctor.phone,
            color: successColor,
          ),
          InfoCardWidget(
            icon: Icons.medical_information_outlined,
            label: "License Number",
            value: doctor.licenseNumber,
            color: Colors.orange,
          ),
          InfoCardWidget(
            icon: Icons.person_outline,
            label: "Gender",
            value: doctor.gender,
            color: purpleColor,
          ),
          InfoCardWidget(
            icon: Icons.location_on_outlined,
            label: "Location",
            value: doctor.place,
            color: errorBgColor,
          ),
          const SizedBox(height: 24),
          if (doctor.licenseProofUrl != null ||
              doctor.profileImageUrl != null) ...[
            const Text(
              "Documents",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (doctor.licenseProofUrl != null)
                  Expanded(
                    child: CertificateButtonWidget(
                      imageUrl: doctor.licenseProofUrl!,
                      text: "License Certificate",
                    ),
                  ),
                if (doctor.licenseProofUrl != null &&
                    doctor.profileImageUrl != null)
                  const SizedBox(width: 12),
                if (doctor.profileImageUrl != null)
                  Expanded(
                    child: CertificateButtonWidget(
                      imageUrl: doctor.profileImageUrl!,
                      text: "Profile Image",
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
