import 'package:get/get.dart';

class UserNotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var filteredNotifications = <NotificationModel>[].obs;
  var searchQuery = ''.obs;
  var filterType = 'Weekly'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    notifications.value = List.generate(
      5,
      (index) => NotificationModel(
        title: "Your Booking has been confirmed!",
        subtitle: "In Mirchi Bar - 04 People - 04:00 PM",
        date: "20-Jan-2025, 3:00 PM",
      ),
    );
    filteredNotifications.assignAll(notifications);
  }

  void filterNotifications(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotifications.assignAll(notifications);
    } else {
      filteredNotifications.assignAll(
        notifications.where((item) =>
            item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.subtitle.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  // Update this method to accept String?
  void changeFilterType(String? type) {
    if (type != null) {
      filterType.value = type;
    }
  }
}

class NotificationModel {
  final String title;
  final String subtitle;
  final String date;

  NotificationModel(
      {required this.title, required this.subtitle, required this.date});
}
