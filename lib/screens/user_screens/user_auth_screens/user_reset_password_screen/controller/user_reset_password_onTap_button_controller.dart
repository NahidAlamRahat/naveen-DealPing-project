import 'package:deal_ping/models/reset_password_model.dart';
import 'package:deal_ping/services/repository/auth_repository/user_reset_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final UserResetPasswordRepository _userResetPasswordRepository =
      Get.put(UserResetPasswordRepository());

  late String token;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      token = Get.arguments['token'] ?? '';
      print(token);
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


  Future<void> onTapResetButton() async {
    print(newPasswordController.text);
    print(confirmPasswordController.text);
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    var resetToken = {"Authorization": token};

    ResetPasswordModel _resetPasswordModel = ResetPasswordModel(
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text);

    final bool isSuccess =
        await _userResetPasswordRepository.resetPasswordApiCaller(
            resetPasswordModel: _resetPasswordModel, resetToken: resetToken);

    if (isSuccess) {
      AppSnackBar.success(
          '${_userResetPasswordRepository.successfullyMessage}');

      print(
          'success message ===> ${_userResetPasswordRepository.successfullyMessage} <===');

      Get.offAllNamed(AppRoutes.userSignInScreen);
    } else {
      AppSnackBar.message('${_userResetPasswordRepository.errorMessage}');
      print('error message => ${_userResetPasswordRepository.errorMessage}');
    }
  }
}
