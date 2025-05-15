import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: question,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.grey700,
            textAlignment: TextAlign.start,
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: answer,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.grey300,
            textAlignment: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
