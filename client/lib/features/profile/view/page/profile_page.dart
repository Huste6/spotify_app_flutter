import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/features/profile/view/page/edit_profile_page.dart';
import 'package:client/features/profile/view/widgets/profile_action_buttons.dart';
import 'package:client/features/profile/view/widgets/profile_header.dart';
import 'package:client/features/profile/view/widgets/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found!'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Pallete.whiteColor,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            ),
            icon: const Icon(
              Icons.edit,
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ProfileHeader(user: user),
            const SizedBox(height: 30,),
            ProfileInfoCard(user:user),
            const SizedBox(height: 30,),
            const ProfileActionButtons(),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
