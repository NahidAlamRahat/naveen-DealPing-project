import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/user_change_password_controller.dart';

class UserChangePasswordScreen extends StatelessWidget {
  final UserChangePasswordController controller =
      Get.put(UserChangePasswordController());

  UserChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.password,
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: AppStrings.currentPassword,
                  fontColor: AppColors.grey700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 8),
                TextFieldWidget(
                  controller: controller.currentPasswordController,
                  hintText: ' Create a Password',
                  maxLines: 1,
                  validator: controller.validateCurrentPassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),
                const SpaceWidget(spaceHeight: 12),

                // Re-type Password
                const TextWidget(
                  text: AppStrings.newPassword,
                  fontColor: AppColors.grey700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 8),
                TextFieldWidget(
                  controller: controller.newPasswordController,
                  hintText: 'Retype your password',
                  maxLines: 1,
                  validator: controller.validateNewPassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: AppStrings.confirmPassword,
                  fontColor: AppColors.grey700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 8),
                TextFieldWidget(
                  controller: controller.confirmPasswordController,
                  hintText: 'Retype your password',
                  maxLines: 1,
                  validator: controller.validateConfirmPassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),
                const SpaceWidget(spaceHeight: 32),
                ButtonWidget(
                  onPressed: () {
                    controller.changePassword();
                  },
                  label: AppStrings.update,
                  buttonWidth: double.infinity,
                  buttonHeight: 52,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
