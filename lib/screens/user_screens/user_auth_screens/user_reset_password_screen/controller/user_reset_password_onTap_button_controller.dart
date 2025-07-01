import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/services/repository/auth_repository/user_reset_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/api_urls.dart';
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

  /* void onTapResetButton() async {
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
        Get.offAllNamed(AppRoutes.userSignInScreen);
      } else {
        AppSnackBar.error("Failed to reset password. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }*/

  Future<void> onTapResetButton() async {
    print(newPasswordController.text);
    print(confirmPasswordController.text);
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    print("tttt");
    var body = {
      "newPassword": newPasswordController.text,
      "confirmPassword": confirmPasswordController.text
    };

    var headers = {"Authorization": token};

    var response =
        await ApiService.postApi(ApiUrls.resetPassword, body, header: headers);

    if (response.statusCode == 200) {
      AppSnackBar.success(
          '${_userResetPasswordRepository.successfullyMessage}');

      Get.offAllNamed(AppRoutes.userSignInScreen);
    } else {
      AppSnackBar.message('${_userResetPasswordRepository.errorMessage}');
      print('error message => ${_userResetPasswordRepository.errorMessage}');
    }

    // ResetPasswordModel _resetPasswordModel = ResetPasswordModel(
    //     newPassword: newPasswordController.text,
    //     confirmPassword: confirmPasswordController.text);
    //
    // bool isSuccess = await _userResetPasswordRepository.resetPasswordApiCaller(
    //     resetPasswordModel: _resetPasswordModel, resetToken: token);
    //
    // print('resetToken => $token');
    //
    // if (isSuccess) {
    //   print(
    //       'success message => ${_userResetPasswordRepository.successfullyMessage}');
    //
    //   AppSnackBar.success(
    //       '${_userResetPasswordRepository.successfullyMessage}');
    //
    //   Get.offAllNamed(AppRoutes.userSignInScreen);
    // } else {
    //   AppSnackBar.message('${_userResetPasswordRepository.errorMessage}');
    //   print('error message => ${_userResetPasswordRepository.errorMessage}');
    // }
  }
}
