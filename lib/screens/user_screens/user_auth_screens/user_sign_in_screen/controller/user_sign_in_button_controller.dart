import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../models/sign_in_model.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/sign_in_api_controller.dart';
import '../../../../../services/repository/auth_repository/google_login_api_controller.dart';
import '../../../../../services/firebase_messaging/firebase_messaging_service.dart';
import '../../../../../utils/app_log/app_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserSignInButtonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignInApiController _signInController = Get.find<SignInApiController>();
  final GoogleLoginApiController _googleLoginController =
      Get.find<GoogleLoginApiController>();

  bool inProgress = false;

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

  Future<void> loginWithGoogle() async {
    try {
      inProgress = true;
      update();

      await GoogleSignIn.instance.initialize(
          serverClientId:
              '169457956060-vkhv8vofqp7h6m93bdiicqdckvpsnfs5.apps.googleusercontent.com');

      // Request authentication.
      final user = await GoogleSignIn.instance.authenticate();

      final authorization = await user.authorizationClient.authorizeScopes([
        'email',
        'profile',
      ]);

      final token = authorization.accessToken;

      print('google login token ==>> $token');

      if (token != null) {
        // Get device token for push notifications
        String? deviceToken;
        try {
          deviceToken = await FirebaseMessagingService.getToken();
        } catch (e) {
          appLog('Failed to get device token: $e');
        }

        // Call Google Login API
        final int statusCode = await _googleLoginController.googleLoginApiCall(
          appId: token,
          deviceToken: deviceToken,
        );

        inProgress = false;
        update();

        if (statusCode == 200) {
          // ✅ Success
          appLog('Google login successful, navigating to user bottom nav');

          AppSnackBar.success(
              _googleLoginController.successfullyMessage.isNotEmpty
                  ? _googleLoginController.successfullyMessage
                  : 'Google Login Successful!');

          // Navigate to user dashboard
          Get.offAllNamed(AppRoutes.userBottomNav);
        } else if (statusCode == 407) {
          // 🚀 OTP verification required
          appLog('OTP verification required for Google login');

          AppSnackBar.message(_googleLoginController.errorMessage.isNotEmpty
              ? _googleLoginController.errorMessage
              : "OTP verification required.");
        } else {
          // ❌ Other errors
          appLog('Google login failed with status code: $statusCode');

          AppSnackBar.message(_googleLoginController.errorMessage.isNotEmpty
              ? _googleLoginController.errorMessage
              : "Google login failed. Please try again.");
        }
      } else {
        inProgress = false;
        update();
        AppSnackBar.message('Failed to get Google access token.');
      }
    } catch (e, stackTrace) {
      inProgress = false;
      update();

      appLog('Exception in Google SignIn: $e');
      appLog('StackTrace: $stackTrace');

      AppSnackBar.message('Google sign in failed. Please try again.');
    }
  }

  Future<void> onTapSignInButton() async {
    if (formKey.currentState!.validate()) {
      try {
        inProgress = true;
        update(); // Update UI for GetBuilder

        SignInModel signInModel = SignInModel(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        appLog('Attempting login for: ${emailController.text.trim()}');

        final int statusCode = await _signInController.signInApiCall(
          signInModel: signInModel,
          email: emailController.text.trim(),
        );

        inProgress = false;
        update(); // Update UI for GetBuilder

        appLog('Login response status code: $statusCode');

        if (statusCode == 200) {
          // ✅ Success
          appLog('Login successful, navigating to business bottom nav');

          AppSnackBar.success(_signInController.successfullyMessage.isNotEmpty
              ? _signInController.successfullyMessage
              : 'Login Successful!');

          // Clear form
          emailController.clear();
          passwordController.clear();

          // Navigate to business dashboard
          Get.offAllNamed(AppRoutes.userBottomNav);
        } else if (statusCode == 407) {
          // 🚀 Special Case - OTP verification required
          appLog('OTP verification required');

          AppSnackBar.message(_signInController.errorMessage.isNotEmpty
              ? _signInController.errorMessage
              : "OTP verification required.");

          Get.toNamed(
            AppRoutes.userSignupVerifyOtpScreen,
            arguments: {'email': emailController.text.trim()},
          );
        } else {
          // ❌ Other errors
          appLog('Login failed with status code: $statusCode');

          AppSnackBar.message(_signInController.errorMessage.isNotEmpty
              ? _signInController.errorMessage
              : "Login failed. Please try again.");
        }
      } catch (e, stackTrace) {
        inProgress = false;
        update(); // Update UI for GetBuilder

        appLog('Exception in SignIn: $e');
        appLog('StackTrace: $stackTrace');

        AppSnackBar.message('Something went wrong. Please try again.');
      }
    }
  }
}
