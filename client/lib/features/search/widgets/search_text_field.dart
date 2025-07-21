import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final bool isSearching;
  final ValueChanged<String> onSeachChanged;
  final VoidCallback onClear;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.isSearching,
    required this.onSeachChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Pallete.transparentColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSearching ? Colors.grey.shade900 : Colors.grey,
          width: 1.5,
        ),
      ),child: TextField(
      controller: controller,
      onChanged: onSeachChanged,
      style: const TextStyle(
        color: Pallete.whiteColor,
      ),
      cursorColor: Pallete.greyColor,
      decoration: InputDecoration(
        hoverColor: Colors.grey.shade900,
        focusColor: Colors.grey.shade900,
        fillColor: Colors.grey.shade900,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        hintText: 'Tìm kiếm bài hát, nghệ sĩ...',
        hintStyle: const TextStyle(color: Pallete.greyColor),
        prefixIcon: const Icon(
          Icons.search,
          color: Pallete.greyColor ,
        ),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
          onPressed: onClear,
          icon: const Icon(
            Icons.clear,
            color: Pallete.greyColor,
          ),
        )
            : null,
        border: InputBorder.none,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    );
  }
}
