import 'package:get/get.dart';

import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
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
      // GetPage(
      //   name: AppRoutes.loginScreen,
      //   page: () => LoginScreen(),
      //   // binding: GeneralBindings(),
      // ),
      // GetPage(
      //   name: AppRoutes.registrationScreen,
      //   page: () => RegistrationScreen(),
      //   // binding: GeneralBindings(),
      // ),
      // GetPage(
      //   name: AppRoutes.emailVerificationScreen,
      //   page: () => EmailVerificationScreen(),
      //   // binding: GeneralBindings(),
      // ),
      // GetPage(
      //   name: AppRoutes.forgotPasswordScreen,
      //   page: () => ForgotPasswordScreen(),
      //   // binding: GeneralBindings(),
      // ),
      // GetPage(
      //   name: AppRoutes.otpVerificationScreen,
      //   page: () => OtpVerificationScreen(),
      //   // binding: GeneralBindings(),
      // ),
      // GetPage(
      //   name: AppRoutes.resetPasswordScreen,
      //   page: () => ResetPasswordScreen(),
      //   // binding: GeneralBindings(),
      // ),
    ];
  }
}
