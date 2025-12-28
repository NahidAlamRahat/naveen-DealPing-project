import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../utils/app_size.dart';
import '../../../../widgets/app_image/app_image.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final Color containerColor;
  final String text;
  final FontWeight textWeight;

  const CategoryWidget({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.containerColor,
    required this.text,
    required this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric( vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: containerColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: AppImage(
                  url: imagePath,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: AppSize.width(value: 110),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: textWeight,
                    color: AppColors.contentColorBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
