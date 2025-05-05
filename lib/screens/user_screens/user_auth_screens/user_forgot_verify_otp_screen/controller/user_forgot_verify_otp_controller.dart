import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/auth_repository.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserForgotVerifyAccountController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var otpTextEditingController1 = TextEditingController();
  var otpTextEditingController2 = TextEditingController();
  var otpTextEditingController3 = TextEditingController();
  var otpTextEditingController4 = TextEditingController();
  var otpTextEditingController5 = TextEditingController();
  var otpTextEditingController6 = TextEditingController();

  var remainingSeconds = 180.obs; // 2.5 minutes
  var canResend = false.obs;
  late String email;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    if (Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      email = args['email'] ?? '';
    } else {
      // Handle the error or provide a default value
      email = '';
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    otpTextEditingController1.dispose();
    otpTextEditingController2.dispose();
    otpTextEditingController3.dispose();
    otpTextEditingController4.dispose();
    otpTextEditingController5.dispose();
    otpTextEditingController6.dispose();
    super.onClose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        print(
            "Timer: ${remainingSeconds.value} seconds remaining"); // Debugging
      } else {
        canResend.value = true;
        print("Timer completed. You can resend the code now."); // Debugging
        _timer.cancel();
      }
    });
  }

  void resendCode() async {
    try {
      bool isSuccess = await AuthRepository().resendOtp(email: email);
      if (isSuccess) {
        AppSnackBar.success("A new OTP has been sent to your email.");
        remainingSeconds.value = 180; // Reset the timer
        canResend.value = false;
        startTimer(); // Restart the timer
      } else {
        AppSnackBar.error("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final remainingSec = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSec.toString().padLeft(2, '0')}';
  }

  void verifyOTP() async {
    if (formKey.currentState!.validate()) {
      try {
        String otp = otpTextEditingController1.text +
            otpTextEditingController2.text +
            otpTextEditingController3.text +
            otpTextEditingController4.text +
            otpTextEditingController5.text +
            otpTextEditingController6.text;

        final authRepository = AuthRepository();
        var response = await authRepository.forgotVerifyEmail(
          email: email,
          otp: otp,
        );

        if (response != null && response["data"] != null) {
          String token = response["data"]["token"];
          AppSnackBar.success("Verification Successful");
          Get.offAllNamed(
            AppRoutes.userResetPasswordScreen,
            arguments: {'token': token},
          );
        } else {
          AppSnackBar.error("Verification Failed. Please try again.");
        }
      } catch (e) {
        AppSnackBar.error("An error occurred. Please try again.");
      }
    } else {
      AppSnackBar.error("Please fill in all required fields.");
    }
  }
}
