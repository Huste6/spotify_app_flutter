import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Pallete.greyColor,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Tìm kiếm bài hát yêu thích',
            style: TextStyle(
              color: Pallete.greyColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Nhập tên bài hát hoặc nghệ sĩ để bắt đầu',
            style: TextStyle(color: Pallete.greyColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
