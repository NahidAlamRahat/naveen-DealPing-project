import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/icon_widget/icon_widget.dart';

class HomeScreenInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onLocationTap;
  final int? maxLines; // Make maxLines optional
  final bool showCharacterCounter; // Add this parameter

  const HomeScreenInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.onLocationTap,
    this.maxLines,
    this.showCharacterCounter = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green200, width: 0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: maxLines ?? 1,
                  // Use maxLines if provided, otherwise default to 1
                  maxLength: showCharacterCounter ? 1000 : null,
                  // Set maxLength only if showCharacterCounter is true
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.grey200,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    counterText: "", // Hide the default counter
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey700,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (onLocationTap != null) // Conditionally render the icon
                GestureDetector(
                  onTap: onLocationTap,
                  child: const IconWidget(
                    icon: AppIconsPath.locationIcon,
                    color: AppColors.green300,
                    width: 22,
                    height: 22,
                  ),
                ),
            ],
          ),
        ),
        if (showCharacterCounter) // Conditionally render the character counter
          Column(
            children: [
              const SizedBox(height: 4), // Add some spacing
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) {
                  return Text(
                    "${controller.text.length}/1000",
                    // Show current character count out of 1000
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey300,
                    ),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
