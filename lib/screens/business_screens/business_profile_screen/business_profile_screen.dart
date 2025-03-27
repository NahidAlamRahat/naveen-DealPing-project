import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const TextWidget(
              text: AppStrings.myProfile,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.grey700,
            ),
            const SpaceWidget(spaceHeight: 24),

            // Profile Section
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const ImageWidget(
                  height: 120,
                  width: 120,
                  imagePath: AppImagePath.businessProfileImage,
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            // Name and Username
            const Center(
              child: TextWidget(
                text: 'Mirchi Dance Bar',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.green500,
              ),
            ),
            const Center(
              child: TextWidget(
                text: '@eyewyiwywyiwuo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey700,
              ),
            ),
            const SpaceWidget(spaceHeight: 12),
            Center(
              child: ButtonWidget(
                onPressed: () {
                  Get.toNamed(AppRoutes.businessEditProfileScreen);
                },
                backgroundColor: AppColors.green500,
                label: AppStrings.editProfile,
                buttonHeight: 36,
                buttonWidth: 100,
                fontSize: 12,
                textColor: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SpaceWidget(spaceHeight: 32),

            // Menu Options
            _buildMenuItem(
              context,
              icon: AppIconsPath.myReportIcon,
              title: AppStrings.myReport,
              onTap: () {
                // Get.toNamed(AppRoutes.aboutUsScreen);
              },
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildMenuItem(
              context,
              icon: AppIconsPath.aboutUsIcon,
              title: AppStrings.aboutUs,
              onTap: () {
                Get.toNamed(AppRoutes.aboutUsScreen);
              },
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildMenuItem(
              context,
              icon: AppIconsPath.termsConditionIcon,
              title: AppStrings.termsCondition,
              onTap: () {
                Get.toNamed(AppRoutes.termsAndConditionsScreen);
              },
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildMenuItem(
              context,
              icon: AppIconsPath.passwordIcon,
              title: AppStrings.password,
              onTap: () {
                Get.toNamed(AppRoutes.userChangePasswordScreen);
              },
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildMenuItem(
              context,
              icon: AppIconsPath.faqIcon,
              title: AppStrings.faq,
              onTap: () {
                Get.toNamed(AppRoutes.faqScreen);
              },
            ),
            const SpaceWidget(spaceHeight: 16),
            _buildMenuItem(
              context,
              icon: AppIconsPath.logoutIcon,
              title: AppStrings.logout,
              onTap: () {
                // Perform logout action (placeholder)
                showCustomPopup(
                  context,
                  [
                    const SpaceWidget(spaceHeight: 34),
                    const Center(
                      child: TextWidget(
                        text: AppStrings.wantToLogout,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.grey700,
                        textAlignment: TextAlign.center,
                      ),
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          label: AppStrings.no,
                          onPressed: () => Navigator.pop(context),
                          buttonHeight: 36,
                          buttonWidth: 71,
                          backgroundColor: AppColors.green50,
                          textColor: AppColors.green500,
                          fontSize: 12,
                        ),
                        const SpaceWidget(spaceWidth: 24),
                        ButtonWidget(
                          label: AppStrings.yes,
                          onPressed: () =>
                              Get.offAllNamed(AppRoutes.userSigninScreen),
                          buttonHeight: 36,
                          buttonWidth: 71,
                          backgroundColor: AppColors.green500,
                          textColor: AppColors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SpaceWidget(spaceHeight: 24),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconWidget(
                icon: icon,
                color: AppColors.green500,
                width: 18,
                height: 18,
              ),
              const SpaceWidget(spaceWidth: 12),
              TextWidget(
                text: title,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey700,
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.grey700,
            size: 12,
          ),
        ],
      ),
    );
  }
}
