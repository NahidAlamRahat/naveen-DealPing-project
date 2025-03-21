import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/screens/user_screens/user_auth_screens/user_sign_in_screen/widgets/social_login_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/business_sign_in_controller.dart';

class BusinessSignInScreen extends StatelessWidget {
  BusinessSignInScreen({super.key});

  final BusinessSignInController controller =
      Get.put(BusinessSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceWidget(spaceHeight: 24),
                const ImageWidget(
                  height: 60,
                  width: 60,
                  imagePath: AppImagePath.appLogoGreen,
                ),
                const SpaceWidget(spaceHeight: 30),
                const TextWidget(
                  text: AppStrings.signInTitle,
                  fontColor: AppColors.green500,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SpaceWidget(spaceHeight: 8),
                const TextWidget(
                  text: AppStrings.signInDescription,
                  fontColor: AppColors.grey700,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: AppStrings.email,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.emailController,
                  hintText: 'Enter Your E-Mail',
                  maxLines: 1,
                  validator: controller.validateEmail,
                ),
                const SpaceWidget(spaceHeight: 12),
                const TextWidget(
                  text: AppStrings.password,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.passwordController,
                  hintText: 'Enter Your Password',
                  maxLines: 1,
                  validator: controller.validatePassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),
                const SpaceWidget(spaceHeight: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButtonWidget(
                    onPressed: () {
                      Get.toNamed(AppRoutes.businessForgotPasswordScreen);
                    },
                    text: AppStrings.forgetPassword,
                    textColor: AppColors.grey700,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SpaceWidget(spaceHeight: 12),
                ButtonWidget(
                  onPressed: controller.signIn,
                  label: AppStrings.signInTitle,
                  buttonWidth: double.infinity,
                  buttonRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                const SpaceWidget(spaceHeight: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 125,
                      color: AppColors.grey300,
                    ),
                    const SpaceWidget(spaceWidth: 8),
                    const TextWidget(
                      text: AppStrings.orLogInWith,
                      fontColor: AppColors.grey700,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    const SpaceWidget(spaceWidth: 8),
                    Container(
                      height: 1,
                      width: 125,
                      color: AppColors.grey300,
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 16),
                SocialLoginWidget(
                  imagePath: AppImagePath.appleIcon,
                  text: AppStrings.signInWithApple,
                  onTap: () {
                    // Handle Apple Sign-In
                  },
                ),
                const SpaceWidget(spaceHeight: 12),
                SocialLoginWidget(
                  imagePath: AppImagePath.googleIcon,
                  text: AppStrings.signInWithGoogle,
                  onTap: () {
                    // Handle Google Sign-In
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              text: AppStrings.dontHaveAnAccount,
              fontColor: AppColors.grey300,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const SpaceWidget(spaceWidth: 4),
            TextButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.businessSignUpScreen);
              },
              text: AppStrings.signUp,
              textColor: AppColors.grey700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
