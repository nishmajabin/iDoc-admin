import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class FeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onInitialize;

  const FeeAppBar({super.key, required this.onInitialize});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "CONSULTATION FEES",
        style: GoogleFonts.poppins(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'initialize') onInitialize();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'initialize',
              child: Row(
                children: [
                  Icon(Icons.restore, size: 20),
                  SizedBox(width: 12),
                  Text('Initialize Default Slabs'),
                ],
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.blue.shade200,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}