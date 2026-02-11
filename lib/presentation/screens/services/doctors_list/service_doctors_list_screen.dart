import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'widgets/doctors_card.dart';
import 'widgets/empty_state_widget.dart';
import 'widgets/error_state_widget.dart';

class ServiceDoctorsListScreen extends StatelessWidget {
  // final DoctorApplicationModel doctor;
  final String categoryName;
  final String categoryImage;

  const ServiceDoctorsListScreen({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
    // required this.doctor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 241, 255),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color(0xFF2D3748),
              ),
              onPressed: () => Navigator.pop(context),
            ),
      ),
      title: Column(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3),
          const Text(
            'Specialists',
            style: TextStyle(
              color: subtitleColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 0),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: primaryColor.withValues(alpha: 0.3), height: 2),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('doctors')
              .where('specialist', isEqualTo: categoryName)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6FCA78)),
            ),
          );
        }

        if (snapshot.hasError) {
          return const ErrorStateWidget();
        }

        final doctors = snapshot.data?.docs ?? [];

        if (doctors.isEmpty) {
          return const EmptyStateWidget();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index].data() as Map<String, dynamic>;
            return DoctorCards(
              doctorApplication: DoctorApplicationModel.fromMap(doctor, doctors[index].id),
              categoryName: categoryName,
            );
          },
        );
      },
    );
  }
}
