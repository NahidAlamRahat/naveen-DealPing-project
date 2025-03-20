import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var selectedOption = 'user'.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  void navigateToNextScreen() {
    if (selectedOption.value == 'user') {
      //Get.to(() => UserScreen());
    } else {
      // Get.to(() => BusinessScreen());
    }
  }
}
