import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/icon_widget/icon_widget.dart';
import '../../../../widgets/image_widget/image_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class ChatMessage extends StatelessWidget {
  final String? text; // Changed to nullable
  final File? image;
  final bool isSent;
  final String time;
  final bool showButton;

  const ChatMessage({
    super.key,
    this.text, // Changed to optional
    this.image,
    required this.isSent,
    required this.time,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(12.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isSent ? AppColors.green500 : AppColors.green50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      image!,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (image != null && text != null) const SizedBox(height: 8),
                if (text != null) // Only show text widget if text exists
                  TextWidget(
                    text: text!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: isSent ? AppColors.white : AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),
                if (showButton) ...[
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.green500,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: const ImageWidget(
                                height: 53,
                                width: 106,
                                imagePath: AppImagePath.bookingsImage,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                    text: 'Mirchi Dance Bar',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                          (index) => const Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const TextWidget(
                                    text: "Dhanmondi, Dhaka",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontColor: AppColors.white,
                                  ),
                                  const Row(
                                    children: [
                                      IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "2.3 miles",
                                        fontSize: 10,
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
                        const SizedBox(height: 10.0),
                        ButtonWidget(
                          onPressed: () {
                            Get.toNamed(AppRoutes.userBookingSummaryScreen);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Table booked successfully!')),
                            // );
                          },
                          backgroundColor: AppColors.white,
                          label: AppStrings.bookYourTable,
                          buttonHeight: 36,
                          buttonWidth: double.infinity,
                          fontSize: 12,
                          textColor: AppColors.grey700,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
