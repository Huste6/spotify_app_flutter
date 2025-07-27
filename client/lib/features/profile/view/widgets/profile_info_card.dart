import 'package:client/cor/model/user_model.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserModel user;
  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Pallete.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Pallete.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.person_2_outlined,
            title: 'Full Name',
            value: user.name,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDivider(),
          const SizedBox(
            height: 20,
          ),
          _buildInfoRow(
            icon: Icons.email_outlined,
            title: 'Email Address',
            value: user.email,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDivider(),
          const SizedBox(
            height: 20,
          ),
          _buildInfoRow(
            icon: Icons.verified_user_outlined,
            title: 'Account status',
            value: 'Active',
            valueColor: Pallete.greenColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Pallete.gradient1.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Pallete.gradient1,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Pallete.greyColor.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              value,
              style: TextStyle(
                  color: valueColor ?? Pallete.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ))
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Pallete.borderColor.withOpacity(0.5),
    );
  }
}
