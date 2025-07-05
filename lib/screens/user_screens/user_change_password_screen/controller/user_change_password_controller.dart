import 'package:deal_ping/models/change_password_model.dart';
import 'package:deal_ping/services/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserResetPasswordRepository _userResetPasswordRepository = UserResetPasswordRepository()

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;

  // Validate Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  // Change Password Action
/*  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    isLoading.value = true;
    try {
      // For debugging
      print("Attempting to change password...");

      bool success = await _authRepository.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // For debugging
      print("Password change result: $success");

      if (success) {
        // Delay navigation slightly to ensure snackbar is visible
        AppSnackBar.message("Password changed successfully.");
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back(); // Navigate back after delay
      } else {
        AppSnackBar.error("Failed to change password.");
      }
    } catch (e) {
      print("Error during password change: $e");
      AppSnackBar.error("An unexpected error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
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

    // var resetToken = {"Authorization": token};

    ChangePasswordModel _rhangePasswordModel = ChangePasswordModel(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text)

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





  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
