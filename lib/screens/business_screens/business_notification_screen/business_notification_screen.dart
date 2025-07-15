import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/user_notification_controller.dart';

class BusinessNotificationScreen extends StatelessWidget {
  final BusinessNotificationController controller =
      Get.put(BusinessNotificationController());

  BusinessNotificationScreen({super.key});

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
          onSelected: (value) {
            if (value == 1) {}
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Mark All As Read",
                style: TextStyle(fontSize: 14, color: AppColors.grey300),
              ),
            ),
          ],
          // offset: Offset(0, 100),
          color: AppColors.white,
          elevation: 2,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => DropdownButton<String>(
                      value: controller.filterType.value,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppColors.green500),
                      items: ["Weekly", "Monthly"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: AppColors.grey300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: controller.changeFilterType,
                    ),
                  ),
                ],
              ),
            ),
            // Notification List
            Obx(() => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      ...List.generate(controller.filteredNotifications.length,
                          (index) {
                        final notification =
                            controller.filteredNotifications[index];
                        return NotificationItem(
                            notification: notification, isNew: index == 0);
                      }),
                    ],
                  ),
                )),
            // View More Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ButtonWidget(
                onPressed: () {},
                label: AppStrings.viewMore,
                buttonHeight: 36,
                buttonWidth: 100,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Notification Item Widget
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final bool isNew;

  const NotificationItem({
    super.key,
    required this.notification,
    this.isNew = false,
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
            borderRadius: BorderRadius.circular(100),
            child: const ImageWidget(
              height: 44,
              width: 44,
              imagePath: AppImagePath.businessNotificationImage,
            ),
          ),
          const SpaceWidget(spaceWidth: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: notification.title,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextWidget(
                  text: notification.subtitle,
                  fontColor: AppColors.grey300,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextWidget(
                  text: notification.date,
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
