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
import '../screens/user_screens/user_bookings_screen/user_bookings_screen.dart';
import '../screens/user_screens/user_bottom_nav/user_bottom_nav.dart';
import '../screens/user_screens/user_chat_list_screen/user_chat_list_screen.dart';
import '../screens/user_screens/user_home_screen/user_home_screen.dart';
import '../screens/user_screens/user_location_screen/user_location_screen.dart';
import '../screens/user_screens/user_notification_screen/user_notification_screen.dart';
import 'app_routes.dart';

class RouteManager {
  RouteManager._();

  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
      // General Screens
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

      // User Screens
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
        name: AppRoutes.userSignupVerifyOtpScreen,
        page: () => const UserSignupVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userForgotPasswordScreen,
        page: () => UserForgotPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userForgotVerifyOtpScreen,
        page: () => const UserForgotVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userResetPasswordScreen,
        page: () => const UserResetPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBottomNav,
        page: () => UserBottomNav(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userHomeScreen,
        page: () => UserHomeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userLocationScreen,
        page: () => UserLocationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userNotificationScreen,
        page: () => UserNotificationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userChatListScreen,
        page: () => UserChatListScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBookingsScreen,
        page: () => UserBookingsScreen(),
        // binding: GeneralBindings(),
      ),

      // Business Screens
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
        name: AppRoutes.businessSignupVerifyOtpScreen,
        page: () => const BusinessSignupVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessForgotPasswordScreen,
        page: () => const BusinessForgotPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessForgotVerifyOtpScreen,
        page: () => const BusinessForgotVerifyOtpScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessResetPasswordScreen,
        page: () => const BusinessResetPasswordScreen(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
