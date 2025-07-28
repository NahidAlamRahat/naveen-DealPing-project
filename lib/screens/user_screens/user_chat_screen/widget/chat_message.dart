/*
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
  final String? text;
  final String? image; // image is now a string URL
  final String time;
  final bool showButton;

  const ChatMessage({
    super.key,
    this.text,
    this.image,
    required this.time,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = image != null && image!.isNotEmpty;
    final bool hasText = text != null && text!.trim().isNotEmpty;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: (hasImage && !hasText)
                ? EdgeInsets.zero
                : const EdgeInsets.all(12.0),
            decoration: (!hasImage && hasText)
                ? BoxDecoration(
              color: AppColors.green50,
              borderRadius: BorderRadius.circular(8),
            )
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      image!,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Failed to load image');
                      },
                    ),
                  ),
                if (hasImage && hasText) const SizedBox(height: 8),
                if (hasText)
                  TextWidget(
                    text: text!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),
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
*/
