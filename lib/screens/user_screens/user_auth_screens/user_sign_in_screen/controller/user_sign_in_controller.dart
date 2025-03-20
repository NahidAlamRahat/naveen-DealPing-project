import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isChecked = false.obs;

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

  // Sign In Action
  void signIn() {
    if (formKey.currentState!.validate()) {
      // Perform login logic (e.g., API call)
      Get.snackbar("Success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Please fill in all required fields.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
