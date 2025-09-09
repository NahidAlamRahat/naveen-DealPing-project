import 'package:deal_ping/screens/business_screens/business_profile_screen/controller/business_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../notification_screen/controller/notification_controller.dart';
import '../../business_home_screen/business_home_screen.dart';
import '../../business_my_report_screen/business_my_report_screen.dart';
import '../../business_profile_screen/business_profile_screen.dart';

class BusinessBottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final  userNotificationController = Get.put(NotificationController());
  final  businessProfileController = Get.put(BusinessProfileController());



  final List<Widget> widgetOptions = [
    const BusinessHomeScreen(),
    const BusinessMyReportScreen(),
    /*const BusinessPresetScreen(),
    BusinessBookingsScreen(),*/
    const BusinessProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
