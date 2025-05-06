import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class SubCategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color containerColor;
  final Color textColor;
  final FontWeight textWeight;

  const SubCategoryWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.containerColor,
    required this.textColor,
    required this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.green200, width: 0.5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: textWeight,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
