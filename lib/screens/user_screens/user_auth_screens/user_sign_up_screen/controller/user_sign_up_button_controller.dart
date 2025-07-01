import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/sign_up_api_controller.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserSignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final UserSignUpApiController _userSignUpApiController =
      Get.find<UserSignUpApiController>();

  final RxBool isLoading = false.obs;

  // final AuthRepository authRepository = AuthRepository();

  // Validate Name
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
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  String? validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }

  // Sign Up Action

/*  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        bool isSuccess = await authRepository.createUser(
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: rePasswordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          role: "user",
        );

        if (isSuccess) {
          AppSnackBar.success("Signup Successful");
          Get.toNamed(
            AppRoutes.userSignupVerifyOtpScreen,
            arguments: {'email': emailController.text},
          );
        } else {
          AppSnackBar.error("Signup Failed. Please try again.");
        }
      } catch (e) {
        AppSnackBar.error("An error occurred. Please try again.");
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackBar.error("Please fill in all required fields.");
    }
  }*/

  Future<void> onTapSignUpButton() async {
    if (formKey.currentState!.validate()) {
      UserSignUpModel userSignUpModel = UserSignUpModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          confirmPassword: rePasswordController.text,
          role: "user");

      final bool isSuccess =
          await _userSignUpApiController.userSignUp(userSignUpModel);
      _userSignUpApiController.signUpInProgress == true;

      if (isSuccess) {
        _userSignUpApiController.signUpInProgress == false;

        AppSnackBar.success(
            _userSignUpApiController.successfullyMessage ?? 'Successful!');
        print(
            'success message => ${_userSignUpApiController.successfullyMessage}');

        Get.toNamed(
          AppRoutes.userSignupVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        _userSignUpApiController.signUpInProgress == false;
        // error message
        AppSnackBar.message('${_userSignUpApiController.errorMessage}');
        print('error message => ${_userSignUpApiController.errorMessage}');
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
