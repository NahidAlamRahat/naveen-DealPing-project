import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Wait for 3 seconds before navigating to the HomeScreen
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.offAllNamed(AppRoutes.onboardingScreen);
      // Get.to(() => BusinessBottomNav());
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed"); // Log message to confirm disposal
  }
}
