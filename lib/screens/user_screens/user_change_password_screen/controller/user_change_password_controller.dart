import 'package:deal_ping/models/change_password_model.dart';
import 'package:deal_ping/screens/user_screens/user_change_password_screen/controller/user_change_password_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserChangePasswordApiCaller _userChangePasswordRepository =
  Get.put(UserChangePasswordApiCaller());

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  late String token;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null && args is Map<String, dynamic> && args['token'] != null) {
      token = args['token'];
      appLog('✅ Received token: $token');
    } else {
      token = '';
      appLog('❌ Token missing in arguments!');
    }
  }

  // Validate password fields
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  Future<void> onTapChangePasswordButton() async {
    // Form validation
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Empty field validation
    if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      AppSnackBar.error("Please fill in all required fields.");
      return;
    }

    // Token check
    if (token.isEmpty) {
      AppSnackBar.error("Authorization token not found!");
      return;
    }

    // Optional: Add "Bearer" if your backend expects it
    var resetToken = {"Authorization": "Bearer $token"};

    ChangePasswordModel changePasswordModel = ChangePasswordModel(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    debugPrint('🔐 Sending token: $token');
    debugPrint('📦 ChangePasswordModel: $changePasswordModel');

    isLoading.value = true;

    final bool isSuccess = await _userChangePasswordRepository.changePasswordApiCaller(
      changePasswordModel: changePasswordModel,
      resetToken: resetToken,
    );

    isLoading.value = false;

    if (isSuccess) {
      AppSnackBar.success('${_userChangePasswordRepository.successfullyMessage}');
      appLog('✅ Success message: ${_userChangePasswordRepository.successfullyMessage}');
      Get.offAllNamed(AppRoutes.userSignInScreen);
    } else {
      AppSnackBar.message('${_userChangePasswordRepository.errorMessage}');
      appLog('❌ Error message: ${_userChangePasswordRepository.errorMessage}');
    }
  }
}