import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../user_edit_profile_screen/user_edit_profile_screen.dart';
import 'controller/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController controller = Get.put(UserProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {


        final profileData = controller.profile.value;

        String fullName = '${profileData?.name} ${profileData?.lastName}' ;

        return RefreshIndicator(
          onRefresh: () async {
            // Prevent multiple refresh calls by checking if data is being loaded
            if (!controller.isLoading.value) {
              await controller.fetchUserProfile();
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
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
                      child: AppImage(
                        height: AppSize.height(value: 120),
                        width: AppSize.width(value: 120),
                        url:  controller.profile.value?.profile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  // Name and Username
                  Center(
                    child: TextWidget(
                      text: fullName,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.green500,
                    ),
                  ),
                  Center(
                    child: TextWidget(
                      text: profileData?.email ?? "",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.grey700,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  Center(
                    child: ButtonWidget(
                      onPressed: () {
                        Get.to(() => const UserEditProfileScreen(), arguments: {
                          'name': profileData?.name ?? "",
                          'lastName': profileData?.lastName,
                          'profileImage': profileData?.profile ?? "",
                        });
                      },
                      backgroundColor: AppColors.green500,
                      label: AppStrings.editProfile,
                      buttonHeight: AppSize.width(value: 36),
                      buttonWidth: AppSize.height(value: 100),
                      fontSize: 12,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 32),

                  // Menu Options
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

                      Get.toNamed(AppRoutes.userChangePasswordScreen, arguments: {
                        'token': LocalStorage.token,
                      });
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
                                buttonHeight: AppSize.height(value: 36),
                                buttonWidth: AppSize.width(value: 71),
                                backgroundColor: AppColors.green50,
                                textColor: AppColors.green500,
                                fontSize: 12,
                              ),
                              const SpaceWidget(spaceWidth: 24),
                              ButtonWidget(
                                label: AppStrings.yes,
                                onPressed: () => controller.logout(),
                                buttonHeight: AppSize.height(value: 36),
                                buttonWidth: AppSize.width(value: 71),
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
          ),
        );
      }),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required String icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconWidget(
                icon: icon,
                color: AppColors.green500,
                width: AppSize.width(value: 18),
                height: AppSize.height(value: 18),
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
