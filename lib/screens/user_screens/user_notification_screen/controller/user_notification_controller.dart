import 'package:get/get.dart';

class UserNotificationController extends GetxController {
  var notifications = <Map<String, String>>[].obs;
  var filteredNotifications = <Map<String, String>>[].obs;
  var searchQuery = ''.obs;
  var filterType = 'Weekly'.obs;
  final filterOptions = ['Weekly', 'Monthly'];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    notifications.value = List.generate(
      5,
      (index) => {
        'title': 'Your Booking has been confirmed!',
        'subtitle': 'In Mirchi Bar - 04 People - 04:00 PM',
        'date': '20-Jan-2025, 3:00 PM',
      },
    );
    filteredNotifications.assignAll(notifications);
  }

  void filterNotifications(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotifications.assignAll(notifications);
    } else {
      filteredNotifications.assignAll(
        notifications.where(
          (item) =>
              (item['title']?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (item['subtitle']?.toLowerCase().contains(query.toLowerCase()) ??
                  false),
        ),
      );
    }
  }

  void changeFilterType(String? type) {
    if (type != null) {
      filterType.value = type;
      // Add logic to filter notifications based on type, e.g., weekly or monthly
      // For now, we'll just update the filter type
      filteredNotifications.assignAll(notifications);
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
