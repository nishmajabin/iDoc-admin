import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';

class UserDetailSliverAppBar extends StatelessWidget {
  final UserModel user;

  const UserDetailSliverAppBar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      elevation: 0,
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, gradientColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildProfileAvatar(),
              const SizedBox(height: 16),
              _buildUserName(),
              const SizedBox(height: 8),
              _buildVerificationBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Hero(
      tag: 'user_${user.uid}',
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipOval(child: _buildProfileImage()),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (user.profileImageUrl == null || user.profileImageUrl!.isEmpty) {
      return Icon(
        Icons.person,
        size: 60,
        color: primaryColor.withOpacity(0.5),
      );
    }

    return CachedNetworkImage(
      imageUrl: user.profileImageUrl!,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) => Container(
        color: primaryColor.withOpacity(0.1),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: primaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.person,
        size: 60,
        color: primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildUserName() {
    return Text(
      user.name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildVerificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user,
            size: 16,
            color: Colors.white.withOpacity(0.9),
          ),
          const SizedBox(width: 6),
          Text(
            'Verified User',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}