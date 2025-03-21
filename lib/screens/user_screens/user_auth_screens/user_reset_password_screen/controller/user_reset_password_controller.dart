import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class UserResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void reset() {
    // Implement your OTP logic here
    // If OTP is successfully received, navigate to the new password screen
    Get.offAllNamed(AppRoutes.userSigninScreen);
  }
}
