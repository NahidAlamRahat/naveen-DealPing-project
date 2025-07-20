import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/forgot_password_repository.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final ForgotPasswordRepository _forgotPasswordRepository =
  Get.put(ForgotPasswordRepository());

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }


  Future<void> onTapBusinessSentEmailButton() async {
    if (emailController.text.isNotEmpty) {
      final bool isSuccess = await _forgotPasswordRepository
          .forgotPasswordApiCall(email: emailController.text.trim());

      _forgotPasswordRepository.inProgress == true;

      if (isSuccess) {
        _forgotPasswordRepository.inProgress == false;

        AppSnackBar.success(_forgotPasswordRepository.successfullyMessage ??
            'Login Successful!');
        appLog('success message => ${_forgotPasswordRepository.errorMessage}');
        Get.toNamed(
          AppRoutes.businessForgotVerifyOtpScreen,
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
