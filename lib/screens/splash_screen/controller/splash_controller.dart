import 'dart:developer';

import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      // Use AppAuthStorage methods instead of direct GetStorage
      String? accessToken = LocalStorage.token;
      String? role = LocalStorage.myRole;
      print("$accessToken😊😊😊😊😊😊");
      print("${LocalStorage.token}😊😊😊😊😊😊");
      if (accessToken != "") {


        if (role == "user") {
          Get.offAllNamed(AppRoutes.userBottomNav);
        } else if (role == "business") {
          Get.offAllNamed(AppRoutes.businessBottomNav);
        } else {
          Get.offAllNamed(AppRoutes.onboardingScreen);
        }
      } else {
        // print("dfhdkjfldlfkjdflk😊😊😊😊😊😊");
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed");
  }
}
