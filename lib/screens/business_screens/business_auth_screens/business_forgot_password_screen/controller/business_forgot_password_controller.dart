import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/auth_repository.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void getOtp() async {
    if (emailController.text.isNotEmpty) {
      try {
        bool isSuccess = await AuthRepository().forgotPassword(
          email: emailController.text,
        );

        if (isSuccess) {
          Get.toNamed(
            AppRoutes.businessForgotVerifyOtpScreen,
            arguments: {'email': emailController.text},
          );
        } else {
          AppSnackBar.error("Failed to send OTP. Please check your email.");
        }
      } catch (e) {
        AppSnackBar.error("An error occurred. Please try again.");
      }
    } else {
      AppSnackBar.error("Please enter your email.");
    }
  }
}
