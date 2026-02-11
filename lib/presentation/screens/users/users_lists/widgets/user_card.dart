import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/users_details_screen.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: blackColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: transparentColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToDetails(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildProfileAvatar(),
                const SizedBox(width: 16),
                _buildUserInfo(),
                const SizedBox(width: 8),
                _buildArrowIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(userId: user.uid),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Hero(
      tag: 'user_${user.uid}',
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              primaryColor.withValues(alpha: 0.1),
              gradientColor.withValues(alpha: 0.1),
            ],
          ),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        child: ClipOval(child: _buildProfileImage()),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (user.profileImageUrl == null || user.profileImageUrl!.isEmpty) {
      return Icon(
        Icons.person,
        size: 35,
        color: primaryColor.withValues(alpha: 0.5),
      );
    }

    return CachedNetworkImage(
      imageUrl: user.profileImageUrl!,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) => Container(
        color: primaryColor.withValues(alpha: 0.05),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primaryColor,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.person,
        size: 35,
        color: primaryColor.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: dashboardTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          _buildEmailRow(),
          if (user.address != null && user.address!.isNotEmpty) ...[
            const SizedBox(height: 6),
            _buildAddressRow(),
          ],
        ],
      ),
    );
  }

  Widget _buildEmailRow() {
    return Row(
      children: [
        Icon(
          Icons.email_outlined,
          size: 14,
          color: subtitleColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            user.email,
            style: TextStyle(
              fontSize: 13,
              color: subtitleColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 14,
          color: locationColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            user.address!,
            style: const TextStyle(
              fontSize: 13,
              color: locationColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildArrowIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: primaryColor,
      ),
    );
  }
}