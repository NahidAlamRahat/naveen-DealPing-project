import 'package:deal_ping/routes/app_routes.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var selectedOption = 'user'.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  void navigateToNextScreen() {
    if (selectedOption.value == 'user') {
      Get.toNamed(AppRoutes.userSignInScreen);
    } else {
      Get.toNamed(AppRoutes.businessSignInScreen);
    }
  }
}
