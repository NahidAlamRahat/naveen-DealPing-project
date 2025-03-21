import 'package:deal_ping/widgets/icon_widget/icon_widget.dart';
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
import 'controller/user_forgot_password_controller.dart';

class UserForgotPasswordScreen extends StatelessWidget {
  final emailController = TextEditingController();

  UserForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserForgotPasswordController controller =
        Get.put(UserForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceWidget(spaceHeight: 24),
              const ImageWidget(
                height: 60,
                width: 60,
                imagePath: AppImagePath.appLogoGreen,
              ),
              const SpaceWidget(spaceHeight: 125),
              const Center(
                child: IconWidget(
                  height: 100,
                  width: 100,
                  icon: AppIconsPath.forgotPasswordIcon,
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: TextWidget(
                    text: AppStrings.forgetPassword,
                    fontColor: AppColors.grey700,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                  ),
                ),
              ),
              const SpaceWidget(spaceHeight: 12),
              const Center(
                child: TextWidget(
                  text: AppStrings.forgotPasswordDesc,
                  fontColor: AppColors.grey300,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              TextFieldWidget(
                controller: controller.emailController,
                hintText: 'Enter Your E-Mail',
                maxLines: 1,
              ),
              const SpaceWidget(spaceHeight: 16),
              ButtonWidget(
                onPressed: controller.getOtp,
                label: AppStrings.submit,
                buttonWidth: double.infinity,
                buttonHeight: 56,
                backgroundColor: AppColors.green500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
