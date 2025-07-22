import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../../services/repository/auth_repository/sign_up_api_controller.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../support_screen/controller/supportApiCallerController.dart';
import '../../../../support_screen/model/request_model.dart';

class UserSignUpButtonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final SignUpApiController _userSignUpApiController =
      Get.find<SignUpApiController>();

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
        appLog(
            'success message => ${_userSignUpApiController.successfullyMessage}');

        Get.toNamed(
          AppRoutes.userSignupVerifyOtpScreen,
          arguments: {'email': emailController.text},
        );
      } else {
        _userSignUpApiController.signUpInProgress == false;
        // error message
        AppSnackBar.message('${_userSignUpApiController.errorMessage}');
        appLog('error message => ${_userSignUpApiController.errorMessage}');
      }
    }
  }


  RxList<SupportFormSection> formSections = <SupportFormSection>[SupportFormSection()].obs;



  Future<void> onTapSubmitSupportRequests() async {
    try {
      // Step 1: Validate all form sections
      for (int i = 0; i < formSections.length; i++) {
        final section = formSections[i];

        if (section.selectedType.value.isEmpty) {
          throw "Section ${i + 1}: Please select a support type.";
        }

        if (section.problemController.text.trim().isEmpty) {
          throw "Section ${i + 1}: Please describe your problem.";
        }

        // Optional: you can add type-specific validations here
      }

      // Step 2: Convert each form section to model and send to API
      for (var section in formSections) {
        String? categoryId =
        section.selectedCategory.value != "empty" ? section.selectedCategory.value : null;
        List<String>? subCategoryList = section.selectedSubCategories.isNotEmpty
            ? section.selectedSubCategories
            : null;

        SupportRequestModel model = SupportRequestModel(
          category: categoryId,
          subcategories: subCategoryList,
          businessName:
          section.selectedType.value == 'Business Name' ? section.problemController.text.trim() : null,
          eiin: section.selectedType.value == 'Eiin Number' ? section.problemController.text.trim() : null,
        );

        appLog("Submitting: ${model.toJson()}");

        // TODO: call your repository API here, for example:
        // await _repository.submitSupportRequest(model.toJson());
      }

      AppSnackBar.success("Support request(s) submitted successfully!");

      // Optionally clear all sections
      formSections.value = [SupportFormSection()];
    } catch (e) {
      AppSnackBar.error(e.toString());
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
