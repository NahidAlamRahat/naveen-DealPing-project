import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user_home_screen/user_home_screen.dart';

class UserBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    UserHomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
