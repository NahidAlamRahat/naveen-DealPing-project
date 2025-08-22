import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/models/notification_model.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/appbar_widget/appbar_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_image_path.dart';
import 'controller/user_notification_controller.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNotificationController>(
        init: UserNotificationController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppbarWidget(
              text: AppStrings.notification,
              backgroundColor: Colors.white,
              centerTitle: true,

              action: PopupMenuButton<int>(
                constraints:
                    const BoxConstraints.expand(width: 150, height: 60),
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
            //   body: LazyListView.builder(
            //     onLoad: controller.onAppInitialDataLoad(),
            //   itemCount: controller.notifications.length,
            //   itemBuilder: (context, index) {
            //     final entry = controller.notifications.elementAt(index);
            //     return NotificationItem(
            //       notification: entry,
            //       isNew: !entry.isRead,
            //       networkImageUrl: entry.userProfileImage,
            //     );
            //   },
            // ),
              body: Obx(() {
                return Stack(
                  children: [
                    // Main content: list of notifications
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.notificationsList.length,
                                (index) {
                              var item = controller.notificationsList[index];
                              appLog('image==>.😪😪 ${ApiUrls.imageUrl}/${item.userProfileImage}');
                              return NotificationItem(
                                notification: item,
                                isNew: !item.isRead,
                                networkImageUrl: '${ApiUrls.baseUrl}/${item.userProfileImage}',
                              );
                            },
                          ),
                          if (controller.isPagination.value)
                            Padding(
                              padding: EdgeInsets.all(AppSize.width(value: 10)),
                              child: Align(
                                child: SizedBox(
                                  width: AppSize.width(value: 20),
                                  height: AppSize.width(value: 20),
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Overlay loader (only visible while loading)
                    if (controller.isLoading.value)
                      const Positioned.fill(
                        child: IgnorePointer(
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),

          );
        });
  }
}

class NotificationItem extends StatelessWidget {

  final NotificationModel notification;
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
    appLog("NotificationItem image URL: $networkImageUrl"); // এখানে URL লগ হবে

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
              networkImageUrl: "${AppImagePath.imageUrl}$networkImageUrl",
            ),
          ),
          const SpaceWidget(spaceWidth: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: notification.businessName,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextWidget(
                  text: notification.body,
                  fontColor: AppColors.grey300,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                const SpaceWidget(spaceHeight: 4),

                TextWidget(
                  text: (DateTime.tryParse(notification.createdAt.toString()) ??
                      DateTime.now())
                      .time ,
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
