import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/sign_in_model.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/sign_in_api_controller.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserSignInButtonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignInApiController _signInController = Get.find<SignInApiController>();

  // Validate Email
  String? validateEmail(String? value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(value ?? "");
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }

  // Validate Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 8) {
      return "Password length should be more than 8 characters";
    }
    return null;
  }

  Future<void> onTapSignInButton() async {
    if (formKey.currentState!.validate()) {
      try {
        // Show loading
        _signInController.inProgress == true;


        SignInModel signInModel = SignInModel(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        final bool isSuccess =
        await _signInController.signInApiCall(signInModel: signInModel, email: emailController.text.trim());

        // Hide loading
        _signInController.inProgress == false;

        if (isSuccess) {
          AppSnackBar.success(
              _signInController.successfullyMessage ?? 'Login Successful!');
          appLog('success message => ${_signInController.successfullyMessage}');
          Get.offAllNamed(AppRoutes.userBottomNav);
        } else {
          AppSnackBar.message('${_signInController.errorMessage}');
          debugPrint('error message => ${_signInController.errorMessage}');
        }
      } catch (e, stackTrace) {
        _signInController.inProgress == false;
        AppSnackBar.message('Something went wrong. Please try again.');
        debugPrint('Exception in SignIn: $e');
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }
}
