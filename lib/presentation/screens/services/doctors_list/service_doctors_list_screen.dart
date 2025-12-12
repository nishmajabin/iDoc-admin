import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/doctor_card.dart';
import 'widgets/empty_state_widget.dart';
import 'widgets/error_state_widget.dart';

class ServiceDoctorsListScreen extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  const ServiceDoctorsListScreen({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
        builder: (context) => IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Column(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              color: Color(0xFF2D3748),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Specialists',
            style: TextStyle(
              color: Color(0xFF718096),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
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
            return DoctorCard(
              doctor: doctor,
              categoryName: categoryName,
            );
          },
        );
      },
    );
  }
}