import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/widgets/loader.dart';
import 'package:client/features/profile/view/widgets/edit_profile_form.dart';
import 'package:client/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final isLoading = ref.watch(profileViewModelProvider)?.isLoading;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not found')),
      );
    }
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Pallete.whiteColor),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: EditProfileForm(user: user),
          ),
          if (isLoading == true) const Loader(),
        ],
      ),
    );
  }
}