import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../widgets/icon_widget/icon_widget.dart';
import '../../../../widgets/image_widget/image_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class BookingCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String distance;
  final int starCount;

  const BookingCardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.distance,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.green500,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: ImageWidget(
              height: 78,
              width: 148,
              imagePath: imagePath,
            ),
          ),
          const SpaceWidget(spaceWidth: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.white,
                ),
                const SpaceWidget(spaceHeight: 4),
                Row(
                  children: List.generate(
                    starCount,
                    (index) => const Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const SpaceWidget(spaceHeight: 2),
                TextWidget(
                  text: location,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.white,
                ),
                Row(
                  children: [
                    const IconWidget(
                      icon: AppIconsPath.locationIconWhite,
                      color: Colors.white,
                      height: 12,
                      width: 12,
                    ),
                    const SpaceWidget(spaceWidth: 4),
                    TextWidget(
                      text: distance,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
