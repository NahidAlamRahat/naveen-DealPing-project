import 'package:deal_ping/screens/user_screens/user_auth_screens/user_signup_verify_otp_screen/user_signup_verify_otp_screen.dart';
import 'package:get/get.dart';

import '../screens/about_us_screen/about_us_screen.dart';
import '../screens/business_screens/business_auth_screens/business_forgot_password_screen/business_forgot_password_screen.dart';
import '../screens/business_screens/business_auth_screens/business_forgot_verify_otp_screen/business_forgot_verify_otp_screen.dart';
import '../screens/business_screens/business_auth_screens/business_reset_password_screen/business_reset_password_screen.dart';
import '../screens/business_screens/business_auth_screens/business_sign_in_screen/business_sign_in_screen.dart';
import '../screens/business_screens/business_auth_screens/business_sign_up_screen/business_sign_up_screen.dart';
import '../screens/business_screens/business_auth_screens/business_signup_verify_otp_screen/business_signup_verify_otp_screen.dart';
import '../screens/business_screens/business_bookings_screen/business_bookings_screen.dart';
import '../screens/business_screens/business_bottom_nav/business_bottom_nav.dart';
import '../screens/business_screens/business_chat_screen/business_chat_screen.dart';
import '../screens/business_screens/business_edit_profile_screen/business_edit_profile_screen.dart';
import '../screens/business_screens/business_home_screen/business_home_screen.dart';
import '../screens/business_screens/business_notification_screen/business_notification_screen.dart';
import '../screens/business_screens/business_preset_screen/business_preset_screen.dart';
import '../screens/business_screens/business_profile_screen/business_profile_screen.dart';
import '../screens/faq_screen/faq_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/terms_condition_screen/terms_condition_screen.dart';
import '../screens/user_screens/user_auth_screens/user_forgot_password_screen/user_forgot_password_screen.dart';
import '../screens/user_screens/user_auth_screens/user_forgot_verify_otp_screen/user_forgot_verify_otp_screen.dart';
import '../screens/user_screens/user_auth_screens/user_reset_password_screen/user_reset_password_screen.dart';
import '../screens/user_screens/user_auth_screens/user_sign_in_screen/user_sign_in_screen.dart';
import '../screens/user_screens/user_auth_screens/user_sign_up_screen/user_sign_up_screen.dart';
import '../screens/user_screens/user_barcode_screen/user_barcode_screen.dart';
import '../screens/user_screens/user_booking_successfull_screen/user_booking_successfull_screen.dart';
import '../screens/user_screens/user_booking_summary_screen/user_booking_summary_screen.dart';
import '../screens/user_screens/user_bookings_screen/user_bookings_screen.dart';
import '../screens/user_screens/user_bottom_nav/user_bottom_nav.dart';
import '../screens/user_screens/user_change_password_screen/user_change_password_screen.dart';
import '../screens/user_screens/user_chat_list_proposal_screen/user_chat_list_proposal_screen.dart';
import '../screens/user_screens/user_chat_list_screen/user_chat_list_screen.dart';
import '../screens/user_screens/user_chat_screen/user_chat_screen.dart';
import '../screens/user_screens/user_edit_profile_screen/user_edit_profile_screen.dart';
import '../screens/user_screens/user_home_screen/user_home_screen.dart';
import '../screens/user_screens/user_location_screen/user_location_screen.dart';
import '../screens/user_screens/user_notification_screen/user_notification_screen.dart';
import '../screens/user_screens/user_profile_screen/user_profile_screen.dart';
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
      GetPage(
        name: AppRoutes.aboutUsScreen,
        page: () => const AboutUsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.termsAndConditionsScreen,
        page: () => const TermsAndConditionsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.faqScreen,
        page: () => FAQScreen(),
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
        name: AppRoutes.userChatListProposalScreen,
        page: () => UserChatListProposalScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userChatScreen,
        page: () => UserChatScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBookingSummaryScreen,
        page: () => UserBookingSummaryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBookingSuccessfullScreen,
        page: () => UserBookingSuccessfullScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBarcodeScreen,
        page: () => UserBarcodeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userBookingsScreen,
        page: () => UserBookingsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userProfileScreen,
        page: () => UserProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userEditProfileScreen,
        page: () => UserEditProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.userChangePasswordScreen,
        page: () => UserChangePasswordScreen(),
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
      GetPage(
        name: AppRoutes.businessBottomNav,
        page: () => BusinessBottomNav(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessProfileScreen,
        page: () => BusinessProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessEditProfileScreen,
        page: () => BusinessEditProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessBookingsScreen,
        page: () => BusinessBookingsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessNotificationScreen,
        page: () => BusinessNotificationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessPresetScreen,
        page: () => BusinessPresetScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessHomeScreen,
        page: () => BusinessHomeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.businessChatScreen,
        page: () => BusinessChatScreen(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
