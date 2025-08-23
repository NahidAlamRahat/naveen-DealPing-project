import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../../services/repository/auth_repository/sign_up_api_controller.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../support_screen/model/request_model.dart';
import '../../../../support_screen/widget/support_form_section.dart';

class UserSignUpButtonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final SignUpApiController _userSignUpApiController =
  Get.find<SignUpApiController>();

  bool isLoading = false;

  // Validate First Name
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Name";
    } else if (value.length < 3) {
      return "Name should be at least 3 characters long";
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Enter a valid name (letters and spaces only)";
    }
    return null;
  }

  // Validate Last Name
  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Name";
    } else if (value.length < 3) {
      return "Name should be at least 3 characters long";
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Enter a valid name (letters and spaces only)";
    }
    return null;
  }

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

  String? validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 8) {
      return "Password length should be more than 8 characters";
    }
    return null;
  }

  Future<void> onTapSignUpButton() async {
    if (formKey.currentState!.validate()) {
      UserSignUpModel userSignUpModel = UserSignUpModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: rePasswordController.text,
        role: "user",
      );

      isLoading = true;
      update(); // ✅ show loading

      final bool isSuccess =
      await _userSignUpApiController.userSignUp(userSignUpModel);

      isLoading = false;
      update(); // ✅ hide loading

      if (isSuccess) {
        AppSnackBar.success(
            _userSignUpApiController.successfullyMessage ?? 'Successful!');
        appLog(
            'success message => ${_userSignUpApiController.successfullyMessage}');

        Get.toNamed(
          AppRoutes.userSignupVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        AppSnackBar.message('${_userSignUpApiController.errorMessage}');
        appLog('error message => ${_userSignUpApiController.errorMessage}');
      }
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }
}
