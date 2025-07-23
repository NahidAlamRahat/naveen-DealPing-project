import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/screens/user_screens/user_bottom_nav/controller/user_bottom_nav_controller.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/widgets/appbar_widget/appbar_widget.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../business_screens/business_notification_screen/controller/business_notification_api_caller_controller.dart';
import 'controller/user_notification_controller.dart';

class UserNotificationScreen extends StatelessWidget {
  final NotificationApiCallerController _apiCallerController = Get.put(NotificationApiCallerController());
  final UserNotificationController controller;

  UserNotificationScreen({super.key}): controller = Get.find<UserBottomNavController>().userNotificationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: AppStrings.notification,
        backgroundColor: Colors.white,
        centerTitle: true,
        action: PopupMenuButton<int>(
          constraints: const BoxConstraints.expand(width: 150, height: 60),
          onSelected: controller.onMarkAllRead,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Mark All As Read",
                style: TextStyle(fontSize: 14, color: AppColors.grey300),
              ),
            ),
          ],
          color: AppColors.white,
          elevation: 2,
        ),
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [
            // Notification List
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: controller.filteredNotifications
                    .asMap()
                    .entries
                    .map((entry) => NotificationItem(
                  notification: entry.value,
                  isNew: entry.key == 0,
                  networkImageUrl: entry.value['image'] ?? '',

                )
                )
                    .toList(),
              ),
            )),

            // View More / Show Less Button
            Obx(() {
              if (controller.notifications.length > 5) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ButtonWidget(
                    onPressed: controller.onToggleNotificationsView,
                    label: controller.isViewMore.value
                        ? AppStrings.viewMore
                        : "Show Less",
                    buttonHeight: 36,
                    buttonWidth: 100,
                    fontSize: 12,
                  ),
                );
              } else {
                return const SizedBox(); // Return empty widget if 5 or fewer
              }
            })

          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Map<String, String> notification;
  final bool isNew;
  final String networkImageUrl;

  const NotificationItem({
    super.key,
    required this.notification,
    this.isNew = false,
    required this.networkImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNew ? AppColors.green50 : AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isNew ? AppColors.green50 : AppColors.grey50,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.width(value: 200)),
            child: NetworkImageWidget(
              fit: BoxFit.cover,
              height: AppSize.height(value: 40),
              width: AppSize.height(value: 40),
              networkImageUrl: networkImageUrl,
            ),
          ),
          const SpaceWidget(spaceWidth: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: notification['title'] ?? '',
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextWidget(
                  text: notification['subtitle'] ?? '',
                  fontColor: AppColors.grey300,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextWidget(
                  text: notification['date'] ?? '',
                  fontColor: AppColors.grey200,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
