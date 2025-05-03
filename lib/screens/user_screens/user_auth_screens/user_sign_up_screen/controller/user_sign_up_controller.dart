import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/auth_repository.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserSignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final RxBool isLoading = false.obs;

  final AuthRepository authRepository = AuthRepository();

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

  Future<void> signUp() async {
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
