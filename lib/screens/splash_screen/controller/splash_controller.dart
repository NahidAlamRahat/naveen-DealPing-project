import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Wait for 3 seconds before navigating to the appropriate screen
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (_storage.read('onboardingShown') == true) {
        // Check if the user is logged in
        if (_storage.read('accessToken') != null) {
          // Get.offAll(() => const BottomNavBar());
        } else {
          Get.offAllNamed(AppRoutes.loginScreen);
        }
      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed"); // Log message to confirm disposal
  }
}
