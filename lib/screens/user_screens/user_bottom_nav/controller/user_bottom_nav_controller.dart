import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user_bookings_screen/user_bookings_screen.dart';
import '../../user_chat_list_screen/user_chat_list_screen.dart';
import '../../user_home_screen/user_home_screen.dart';
import '../../user_profile_screen/user_profile_screen.dart';

class UserBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    UserHomeScreen(),
    UserChatListScreen(),
    UserBookingsScreen(),
    UserProfileScreen(),
  ];

  void changeIndex(int index) {
  try{
    selectedIndex.value = index;
    update();
  }catch(e){}
  }
}
