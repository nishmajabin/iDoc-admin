import 'package:flutter/material.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/add_category/header_section.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/add_category/image_section.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/add_category/name_field.dart';

class AddCategoryCard extends StatelessWidget {
  final TextEditingController nameController;

  const AddCategoryCard({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderSection(),
          const SizedBox(height: 24),
          NameField(controller: nameController),
          const SizedBox(height: 20),
          ImageSection(nameController: nameController),
        ],
      ),
    );
  }
}
