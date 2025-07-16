import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../user_screens/user_notification_screen/controller/user_notification_controller.dart';
import '../../business_bookings_screen/business_bookings_screen.dart';
import '../../business_home_screen/business_home_screen.dart';
import '../../business_preset_screen/business_preset_screen.dart';
import '../../business_profile_screen/business_profile_screen.dart';

class BusinessBottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final  userNotificationController = Get.put(UserNotificationController());


  final List<Widget> widgetOptions = [
    BusinessHomeScreen(),
    BusinessPresetScreen(),
    BusinessBookingsScreen(),
    const BusinessProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
