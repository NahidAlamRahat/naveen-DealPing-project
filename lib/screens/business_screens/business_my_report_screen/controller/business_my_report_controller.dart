import 'package:get/get.dart';

class ReportController extends GetxController {
  RxString filterType =
      "Weekly".obs; // Default value must match one of the items

  void changeFilterType(String? newValue) {
    if (newValue != null) {
      filterType.value = newValue;
    }
  }
}
