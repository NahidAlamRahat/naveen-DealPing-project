import 'package:deal_ping/models/user-growth.dart';
import 'package:deal_ping/services/repository/common_repository/common_repository.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:get/get.dart';

import '../../../../models/booking-growth.dart';

class ReportController extends GetxController {
  CommonRepository commonRepository = CommonRepository();

  // আলাদা filterType দুইটার জন্য
  RxString userFilterType = "Month".obs;
  RxString bookingFilterType = "Month".obs;

  Rx<BookingStatsResponse?> bookingStats = Rx<BookingStatsResponse?>(null);
  Rx<UserGrowthResponse?> userStats = Rx<UserGrowthResponse?>(null);

  // আলাদা selectedTabIndex
  RxInt userSelectedTabIndex = 0.obs;
  RxInt bookingSelectedTabIndex = 0.obs;

  void changeUserSelectedTab(int index) {
    userSelectedTabIndex.value = index;
  }

  void changeBookingSelectedTab(int index) {
    bookingSelectedTabIndex.value = index;
  }

  // শুধু User Growth API কল
  void changeUserFilterType(String? newValue) async {
    if (newValue != null) {
      userFilterType.value = newValue;
      appLog("User FilterType ===>> ${userFilterType.value}");

      final response = await commonRepository.userGrowth(
        status: userFilterType.value.toLowerCase(),
      );

      if (response != null) {
        userStats.value = response;
        appLog("Bookings: ${response.bookings.length}");
        appLog("Requests: ${response.requests.length}");
      }
    }
  }

  // শুধু Booking Growth API কল
  void changeBookingFilterType(String? newValue) async {
    if (newValue != null) {
      bookingFilterType.value = newValue;
      appLog("Booking FilterType ===>> ${bookingFilterType.value}");

      final result = await commonRepository.bookingGrowth(
        status: bookingFilterType.value.toLowerCase(),
      );

      if (result != null) {
        bookingStats.value = result;
        appLog("Placed: ${result.placed.length}");
        appLog("Converted: ${result.converted.length}");
      }
    }
  }
}


