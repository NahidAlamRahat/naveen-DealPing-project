import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';


/// This class manages individual form section state
class SupportFormSection {
  final RxString selectedType = ''.obs;

  final RxString selectedCategory = "empty".obs;
  final RxString selectedCategoryId = 'empty'.obs; // Now stores ID instead of title
  final RxList<String> selectedSubCategories = <String>[].obs;

  final TextEditingController problemController = TextEditingController();
  final TextEditingController inputFieldController = TextEditingController();

  // IMPROVEMENT: Add dispose method to clean up controllers
  void dispose() {
    problemController.dispose();
    inputFieldController.dispose();
  }

}