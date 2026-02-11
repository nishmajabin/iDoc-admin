import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';

class CardContent extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const CardContent({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feeSlab.experienceRange,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${feeSlab.consultationFee.toStringAsFixed(0)} per consultation',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}