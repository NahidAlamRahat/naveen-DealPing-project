
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/screens/user_screens/user_notification_screen/controller/user_notification_api_caller_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


///==================================

class UserNotificationController extends GetxController {
  ScrollController scrollController = ScrollController();
  UserNotificationApiCallerController _apiCallerController = Get.put(UserNotificationApiCallerController());
  var notifications = <Map<String, String>>[

  ].obs;
  var filteredNotifications = <Map<String, String>>[].obs;
  var searchQuery = ''.obs;
  var filterType = 'Weekly'.obs;
  var isViewMore = true.obs; // To manage view state
  final filterOptions = ['Weekly', 'Monthly'];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    scrollController.addListener((){
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        print("========================> max extent called");
        fetchNotifications();
      }
    });
  }



  Future<void> fetchNotifications() async{

    await _apiCallerController.getNotificationList();
    print("_apiCallerController.notificationList ====================>>>>>   ${_apiCallerController.notificationList}");
    notifications.value = List.generate(
        _apiCallerController.notificationList.length,
          (index) => {
        'title': _apiCallerController.notificationList[index].businessName,  // businessName
        'subtitle': _apiCallerController.notificationList[index].body,  // body
        'date': _apiCallerController.notificationList[index].createdAt,
        'image' : '${AppImagePath.imageUrl}${_apiCallerController.notificationList[index].userProfileImage}' // createdAt
      },
    );
    filteredNotifications.assignAll(notifications);
  }

  void onToggleNotificationsView() {
    isViewMore.value = !isViewMore.value;
    if (isViewMore.value) {
      filteredNotifications.assignAll(notifications);  // Show less (show all notifications)
    } else {
      filteredNotifications.assignAll(notifications.take(5));  // Show more (show only 5 notifications)
    }
  }

  void filterNotifications(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotifications.assignAll(notifications);
    } else {
      filteredNotifications.assignAll(
        notifications.where(
              (item) =>
          (item['title']?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (item['subtitle']?.toLowerCase().contains(query.toLowerCase()) ?? false),
        ),
      );
    }
  }

  void onMarkAllRead(int value) {
    if (value == 1) {
      // Logic for marking all notifications as read
      // For demo, we can clear the "new" status or update UI state
      Get.snackbar('Notifications', 'All marked as read');
    }
  }

  void onViewMore() {
    // Logic for loading more notifications
    Get.snackbar('View More', 'Loading more notifications...');
  }
}
