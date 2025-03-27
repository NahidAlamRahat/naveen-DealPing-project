import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../business_bookings_screen/business_bookings_screen.dart';
import '../../business_preset_screen/business_preset_screen.dart';
import '../../business_profile_screen/business_profile_screen.dart';

class BusinessBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    Container(),
    BusinessPresetScreen(),
    BusinessBookingsScreen(),
    const BusinessProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
