import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/auth_repository.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late String token;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      token = Get.arguments['token'] ?? '';
    } else {
      token = '';
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void reset() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      AppSnackBar.error("Passwords do not match.");
      return;
    }

    try {
      bool isSuccess = await AuthRepository().resetPassword(
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
        token: token,
      );

      if (isSuccess) {
        AppSnackBar.success("Password reset successfully.");
        Get.offAllNamed(AppRoutes.businessSignInScreen);
      } else {
        AppSnackBar.error("Failed to reset password. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }
}
