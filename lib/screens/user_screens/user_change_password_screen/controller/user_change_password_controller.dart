import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class UserChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isChecked = false.obs;
  final RxBool isChecked2 = false.obs;
  final RxBool isChecked3 = false.obs;

  // Validate Name

  // Validate Password
  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  // Sign Up Action
  void changePassword() {
    if (formKey.currentState!.validate()) {
      // Perform login logic (e.g., API call)
      Get.snackbar("Success", "Signup Successful",
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(AppRoutes.userSignupVerifyOtpScreen);
    } else {
      Get.snackbar("Error", "Please fill in all required fields.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
