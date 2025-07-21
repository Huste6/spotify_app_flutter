import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchNoResults extends StatelessWidget {
  const SearchNoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_off,
            size: 80,
            color: Pallete.greyColor,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Không tìm thấy kết quả',
            style: TextStyle(
              color: Pallete.greyColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Thử tìm kiếm với từ khóa khác',
            style: TextStyle(
              color: Pallete.greyColor,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
