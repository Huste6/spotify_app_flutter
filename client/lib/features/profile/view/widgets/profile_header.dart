import 'package:client/cor/model/user_model.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(
          height: 16,
        ),
        _buildUserField(user.name, Pallete.whiteColor),
        const SizedBox(
          height: 8,
        ),
        _buildUserField(user.email, Pallete.greyColor.withOpacity(0.7)),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Pallete.gradient1,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Pallete.gradient1.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: user.avatar.isNotEmpty
            ? Image.network(
                user.avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar();
                },
                loadingBuilder: (context, child, loadingProcess) {
                  if (loadingProcess == null) return child;
                  return _buildLoadingAvatar();
                },
              )
            : _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Pallete.gradient1, Pallete.gradient2],
        ),
      ),
      child: const Icon(
        Icons.person,
        size: 60,
        color: Pallete.whiteColor,
      ),
    );
  }

  Widget _buildLoadingAvatar() {
    return Container(
      decoration: const BoxDecoration(
        color: Pallete.greyColor,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Pallete.gradient1,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildUserField(String text, Color colors) {
    return Text(
      text,
      style: TextStyle(
        color: colors,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
