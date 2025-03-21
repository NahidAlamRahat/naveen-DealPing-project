import 'package:deal_ping/screens/user_screens/user_auth_screens/user_signup_verify_otp_screen/user_signup_verify_otp_screen.dart';
import 'package:get/get.dart';

import '../screens/business_screens/business_auth_screens/business_forgot_password_screen/business_forgot_password_screen.dart';
import '../screens/business_screens/business_auth_screens/business_forgot_verify_otp_screen/business_forgot_verify_otp_screen.dart';
import '../screens/business_screens/business_auth_screens/business_reset_password_screen/business_reset_password_screen.dart';
import '../screens/business_screens/business_auth_screens/business_sign_in_screen/business_sign_in_screen.dart';
import '../screens/business_screens/business_auth_screens/business_sign_up_screen/business_sign_up_screen.dart';
import '../screens/business_screens/business_auth_screens/business_signup_verify_otp_screen/business_signup_verify_otp_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/user_screens/user_auth_screens/user_forgot_password_screen/user_forgot_password_screen.dart';
import '../screens/user_screens/user_auth_screens/user_forgot_verify_otp_screen/user_forgot_verify_otp_screen.dart';
import '../screens/user_screens/user_auth_screens/user_reset_password_screen/user_reset_password_screen.dart';
import '../screens/user_screens/user_auth_screens/user_sign_in_screen/user_sign_in_screen.dart';
import '../screens/user_screens/user_auth_screens/user_sign_up_screen/user_sign_up_screen.dart';
import 'app_routes.dart';

class RouteManager {
  RouteManager._();

  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.onboardingScreen,
        page: () => OnboardingScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userSigninScreen,
        page: () => UserSignInScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userSignUpScreen,
        page: () => UserSignUpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessSignInScreen,
        page: () => BusinessSignInScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessSignUpScreen,
        page: () => BusinessSignUpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userSignupVerifyOtpScreen,
        page: () => UserSignupVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userForgotPasswordScreen,
        page: () => UserForgotPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userForgotVerifyOtpScreen,
        page: () => UserForgotVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userResetPasswordScreen,
        page: () => UserResetPasswordScreen(),
        // binding: GeneralBindings(),
      ),

      // Business Screens
      GetPage(
        name: AppRoutes.businessSignupVerifyOtpScreen,
        page: () => BusinessSignupVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessForgotPasswordScreen,
        page: () => BusinessForgotPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessForgotVerifyOtpScreen,
        page: () => BusinessForgotVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessResetPasswordScreen,
        page: () => BusinessResetPasswordScreen(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
