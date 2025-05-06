import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/category_model.dart';
import '../../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserHomeController extends GetxController {
  final UserHomeRepository _repository = UserHomeRepository();

  // Text Controllers
  final locationController = TextEditingController();
  final messageController = TextEditingController();

  var isLoading = false.obs;
  var categories = <Data>[].obs;
  var subCategories = <String>[].obs;

  // Selected Values
  var selectedCategory = "".obs; // Initially empty (no selection)
  var selectedSubCategory = "".obs; // Initially empty (no selection)

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    isLoading.value = true;
    try {
      final categoryResponse = await _repository.fetchCategories();
      if (categoryResponse != null && categoryResponse.success == true) {
        categories.value = categoryResponse.data ?? [];
      } else {
        AppSnackBar.error(
            categoryResponse?.message ?? "Failed to load categories.");
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  // Select Category

  void selectCategory(String category) {
    selectedCategory.value = category;
    selectedSubCategory.value = ""; // Reset subcategory when category changes

    // Find the selected category's subcategories
    final selectedCategoryData = categories.firstWhere(
      (cat) => cat.title == category,
      orElse: () => Data(),
    );

    // Update the subcategories list
    subCategories.value = selectedCategoryData.subCategories
            ?.map((subCategory) => subCategory.title ?? "")
            .toList() ??
        [];
  }

  // Select Sub-Category
  void selectSubCategory(String subCategory) {
    selectedSubCategory.value = subCategory;
  }

  // Navigate to Location Screen
  void navigateToLocationScreen() async {
    final selectedLocation = await Get.toNamed('/userLocationScreen');
    if (selectedLocation != null) {
      locationController.text = selectedLocation;
    }
  }

  // Dispose resources
  @override
  void onClose() {
    locationController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
