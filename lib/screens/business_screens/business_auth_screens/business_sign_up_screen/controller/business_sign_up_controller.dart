import 'package:deal_ping/models/business_sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/auth_repository.dart';
import '../../../../../services/repository/auth_repository/sign_up_api_controller.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessSignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController eiinNumberController = TextEditingController();
  final TextEditingController licenceNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final SignUpApiController _signUpApiController =
      Get.put(SignUpApiController());

  final RxBool isLoading = false.obs;

  final AuthRepository authRepository = AuthRepository();

  // Validate Name
  String? validateBusinessName(String? value) {
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


  Future<void> onTapBusinessSignUpButton() async {
    if (formKey.currentState!.validate()) {
      BusinessSignUpModel _businessSignUpModel = BusinessSignUpModel(
          licenceNumber: licenceNumberController.text.trim(),
          businessName: businessNameController.text.trim(),
          eiinNumber: eiinNumberController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          role: 'business');

      final bool isSuccess =
          await _signUpApiController.userSignUp(_businessSignUpModel);
      _signUpApiController.signUpInProgress == true;

      if (isSuccess) {
        _signUpApiController.signUpInProgress == false;

        AppSnackBar.success(
            _signUpApiController.successfullyMessage ?? 'Successful!');
        print('success message => ${_signUpApiController.successfullyMessage}');

        Get.toNamed(
          AppRoutes.businessSignupVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        _signUpApiController.signUpInProgress == false;
        // error message
        AppSnackBar.message('${_signUpApiController.errorMessage}');
        print('error message => ${_signUpApiController.errorMessage}');
      }
    }
  }

  @override
  void onClose() {
    businessNameController.dispose();
    eiinNumberController.dispose();
    licenceNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
