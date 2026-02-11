import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(blueShade600),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading applications...',
            style: TextStyle(color: unselectedColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
