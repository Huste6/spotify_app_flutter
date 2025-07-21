import 'package:client/cor/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchErrorState extends StatelessWidget {
  final String error;

  const SearchErrorState({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Có lỗi xảy ra',
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Pallete.greyColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}