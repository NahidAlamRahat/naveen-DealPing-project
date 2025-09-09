import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/profile_model.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../notification_screen/controller/notification_controller.dart';
import '../../user_chat_list_screen/user_chat_list_screen.dart';
import '../../user_home_screen/user_home_screen.dart';
import '../../user_profile_screen/user_profile_screen.dart';


Rxn<Profile> userProfileData = Rxn();



class UserBottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final  userNotificationController = Get.put(NotificationController());

  final List<Widget> widgetOptions = [
    const UserHomeScreen(),
    UserChatListScreen(),
    // const UserBookingsScreen(),
    const UserProfileScreen(),
  ];

  void changeIndex(int index) {
  try{
    selectedIndex.value = index;
    update();
  }catch(e){
    appLog(e) ;
  }
  }
}
