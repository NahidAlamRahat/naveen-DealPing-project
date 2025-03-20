import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../widgets/image_widget/image_widget.dart';
import '../../../../../widgets/text_widget/text_widgets.dart';

class SocialLoginWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const SocialLoginWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageWidget(
              height: 20,
              width: 20,
              imagePath: imagePath,
            ),
            TextWidget(
              text: text,
              fontColor: AppColors.grey700,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
