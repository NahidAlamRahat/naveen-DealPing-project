import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/api_urls.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../models/chat_message_responce_model.dart';
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
  final String? type;
  final String? offerTitle;
  final String? offerImageUrl;
  final double? distance;
  final Sender? sender; // to get address



  const ChatMessage({
    super.key,
    this.text,
    this.type,
    this.image,
    required this.isSent,
    required this.time,
    this.showButton = false,
    this.offerTitle,
    this.offerImageUrl,
    this.distance,
    this.sender,
  });

  @override
  Widget build(BuildContext context) {

    final ChatMessageResponseModel message;



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


          ///error solve
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

                if (text != null)
                  Container(
                    decoration: BoxDecoration(
                      color: (image == null)
                          ? (isSent ? AppColors.green500 : AppColors.green50)
                          : null, // ✅ Only apply color when no image
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: TextWidget(
                      text: text!,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: (image == null)
                          ? (isSent ? AppColors.white : AppColors.grey700)
                          : AppColors.grey200, // ✅ Optional: adjust font color when no background
                      textAlignment: TextAlign.start,
                    ),

                  ),

                //========================================
                //========================================

                if (type == 'offer') ...[
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
                              child: offerImageUrl != null && offerImageUrl!.isNotEmpty
                                  ? Image.network(
                                "${ApiUrls.baseUrl}$offerImageUrl",
                                height: 53,
                                width: 106,
                                fit: BoxFit.cover,
                              )
                                  : const ImageWidget(
                                height: 53,
                                width: 106,
                                imagePath: AppImagePath.bookingsImage,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// ✅ Dynamic Offer title
                                  TextWidget(
                                    text: offerTitle ?? 'Offer',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  TextWidget(
                                    text: sender?.address ?? 'Unknown',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontColor: AppColors.white,
                                  ),
                                  Row(
                                    children: [
                                      const IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: distance != null ? "${distance!.toStringAsFixed(1)} miles" : "N/A",
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Table booked successfully!')),
                            );
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
