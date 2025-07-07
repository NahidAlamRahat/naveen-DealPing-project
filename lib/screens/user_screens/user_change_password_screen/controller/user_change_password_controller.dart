import 'package:deal_ping/models/change_password_model.dart';
import 'package:deal_ping/screens/user_screens/user_change_password_screen/controller/user_change_password_api_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserChangePasswordController extends GetxController {



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserChangePasswordApiCaller _userChangePasswordRepository =
  Get.put(UserChangePasswordApiCaller());

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
/*
  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    currentPasswordController.dispose();

    super.onClose();
  }*/


  Future<void> onTapChangePasswordButton() async {
    print(newPasswordController.text);
    print(confirmPasswordController.text);
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    var resetToken = {"Authorization": token};

       ChangePasswordModel _changePasswordModel = ChangePasswordModel(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text);

       debugPrint('token ===>  $token');

    final bool isSuccess =
    await _userChangePasswordRepository.changePasswordApiCaller(
        changePasswordModel: _changePasswordModel, resetToken: resetToken);

    if (isSuccess) {
      AppSnackBar.success(
          '${_userChangePasswordRepository.successfullyMessage}');

      print(
          'success message ===> ${_userChangePasswordRepository.successfullyMessage} <===');

      Get.offAllNamed(AppRoutes.userSignInScreen);
    } else {
      AppSnackBar.message('${_userChangePasswordRepository.errorMessage}');
      print('error message => ${_userChangePasswordRepository.errorMessage}');
    }
  }
}












