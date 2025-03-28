import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class BusinessSignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController businessFirstNameController =
      TextEditingController();
  final TextEditingController businessLastNameController =
      TextEditingController();
  final TextEditingController eiinNumberController = TextEditingController();
  final TextEditingController licenceNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isChecked = false.obs;
  final RxBool isChecked2 = false.obs;

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
  } // Validate Name

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Name";
    } else if (value.length < 3) {
      return "Name should be at least 3 characters long";
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Enter a valid name (letters and spaces only)";
    }
    return null;
  } // Validate Name

  // Validate EIIN Number
  String? validateEiinNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter EIIN Number";
    } else if (!RegExp(r"^\d{6}$").hasMatch(value)) {
      return "Enter a valid 6-digit EIIN Number";
    }
    return null;
  }

  // Validate Licence Number
  String? validateLicenseNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter License Number";
    } else if (!RegExp(r"^[A-Z0-9-]{6,15}$").hasMatch(value)) {
      return "Enter a valid License Number (6-15 characters, uppercase letters, numbers, and hyphens only)";
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
  void signUp() {
    if (formKey.currentState!.validate()) {
      // Perform login logic (e.g., API call)
      Get.snackbar("Success", "Signup Successful",
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(
        AppRoutes.businessSignupVerifyOtpScreen,
        arguments: {'email': emailController.text},
      );
    } else {
      Get.snackbar("Error", "Please fill in all required fields.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    businessFirstNameController.dispose();
    businessLastNameController.dispose();
    eiinNumberController.dispose();
    licenceNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
