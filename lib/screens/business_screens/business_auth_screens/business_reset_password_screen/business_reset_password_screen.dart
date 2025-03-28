import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/image_widget/image_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/business_reset_password_controller.dart';

class BusinessResetPasswordScreen extends StatelessWidget {
  const BusinessResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BusinessResetPasswordController controller =
        Get.put(BusinessResetPasswordController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceWidget(spaceHeight: 24),
            const ImageWidget(
              height: 60,
              width: 60,
              imagePath: AppImagePath.appLogoGreen,
              fit: BoxFit.contain,
            ),
            const SpaceWidget(spaceHeight: 165),
            const Center(
              child: TextWidget(
                text: AppStrings.createNewPassword,
                fontColor: AppColors.grey700,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            const Center(
              child: TextWidget(
                text: AppStrings.passwordMustBeDifferent,
                fontColor: AppColors.grey300,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            TextFieldWidget(
              controller: controller.newPasswordController,
              hintText: 'New Password',
              maxLines: 1,
              suffixIcon: AppIconsPath.visibilityOff,
            ),
            const SpaceWidget(spaceHeight: 16),
            TextFieldWidget(
              controller: controller.confirmPasswordController,
              hintText: 'Confirm Password',
              maxLines: 1,
              suffixIcon: AppIconsPath.visibilityOff,
            ),
            const SpaceWidget(spaceHeight: 24),
            ButtonWidget(
              onPressed: controller.reset,
              label: AppStrings.resetPassword,
              buttonWidth: double.infinity,
              buttonHeight: 56,
              backgroundColor: AppColors.green500,
            ),
          ],
        ),
      ),
    );
  }
}
