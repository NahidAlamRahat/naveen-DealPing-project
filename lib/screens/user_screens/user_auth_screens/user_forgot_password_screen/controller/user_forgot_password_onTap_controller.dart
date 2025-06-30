import 'package:deal_ping/services/repository/auth_repository/forgot_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserForgotPasswordOnTapController extends GetxController {
  final emailController = TextEditingController();
  final ForgotPasswordRepository _forgotPasswordRepository =
      Get.put(ForgotPasswordRepository());

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

/*  void getOtp() async {
    if (emailController.text.isNotEmpty) {
      try {
        bool isSuccess = await AuthRepository().forgotPassword(
          email: emailController.text,
        );

        debugPrint('success => $isSuccess');

        if (isSuccess) {
          debugPrint('success => $isSuccess');
          Get.toNamed(
            AppRoutes.userForgotVerifyOtpScreen,
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
  }*/

  Future<void> onTapSentEmailButton() async {
    if (emailController.text.isNotEmpty) {
      final bool isSuccess = await _forgotPasswordRepository
          .forgotPasswordApiCall(email: emailController.text.trim());

      _forgotPasswordRepository.inProgress == true;

      if (isSuccess) {
        _forgotPasswordRepository.inProgress == false;

        AppSnackBar.success(_forgotPasswordRepository.successfullyMessage ??
            'Login Successful!');
        print('success message => ${_forgotPasswordRepository.errorMessage}');
        Get.toNamed(
          AppRoutes.userForgotVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        _forgotPasswordRepository.inProgress == false;
        // error message
        AppSnackBar.message('${_forgotPasswordRepository.errorMessage}');
        debugPrint(
            'error message => ${_forgotPasswordRepository.errorMessage}');
      }
    } else {
      AppSnackBar.error("Please enter your email.");
    }
  }
}
