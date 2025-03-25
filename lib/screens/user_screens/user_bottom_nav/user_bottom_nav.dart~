import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_image_path.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import 'controller/user_bottom_nav_controller.dart';

class UserBottomNav extends StatelessWidget {
  UserBottomNav({super.key});

  final UserBottomNavController controller = Get.put(UserBottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 64,
        flexibleSpace: Container(color: AppColors.white),
        titleSpacing: -1,
        title: const Padding(
          padding: EdgeInsets.only(left: 20, top: 12),
          child: ImageWidget(
            imagePath: AppImagePath.appLogoGreen,
            width: 50,
            height: 50,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Notifications",
            onPressed: () {
              Get.toNamed(AppRoutes.userNotificationScreen);
            },
            icon: const Badge(
              isLabelVisible: true,
              label: Text("3"),
              backgroundColor: AppColors.red,
              child: IconWidget(
                icon: AppIconsPath.notificationIcon,
                width: 24,
                height: 24,
                color: AppColors.grey700,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => Center(
          child: controller.widgetOptions[controller.selectedIndex.value])),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Obx(
              () => GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.green500,
                backgroundColor: AppColors.white,
                textStyle: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
                tabBorderRadius: 8,
                tabs: [
                  GButton(
                    text: AppStrings.home,
                    leading: IconWidget(
                      icon: AppIconsPath.homeIcon,
                      width: 24,
                      height: 24,
                      color: controller.selectedIndex.value == 0
                          ? AppColors.white
                          : AppColors.grey300,
                    ),
                    icon: Icons.home,
                  ),
                  GButton(
                    text: AppStrings.chat,
                    leading: IconWidget(
                      icon: AppIconsPath.chatIcon,
                      width: 24,
                      height: 24,
                      color: controller.selectedIndex.value == 1
                          ? AppColors.white
                          : AppColors.grey300,
                    ),
                    icon: Icons.home,
                  ),
                  GButton(
                    text: AppStrings.bookings,
                    leading: IconWidget(
                      icon: AppIconsPath.bookingsIcon,
                      width: 24,
                      height: 24,
                      color: controller.selectedIndex.value == 2
                          ? AppColors.white
                          : AppColors.grey300,
                    ),
                    icon: Icons.home,
                  ),
                  GButton(
                    text: AppStrings.profile,
                    leading: IconWidget(
                      icon: AppIconsPath.profileIcon,
                      width: 24,
                      height: 24,
                      color: controller.selectedIndex.value == 3
                          ? AppColors.white
                          : AppColors.grey300,
                    ),
                    icon: Icons.home,
                  ),
                ],
                selectedIndex: controller.selectedIndex.value,
                onTabChange: (index) => controller.changeIndex(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
