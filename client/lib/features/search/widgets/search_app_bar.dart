import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      title: const Text(
        'Tìm kiếm',
        style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
