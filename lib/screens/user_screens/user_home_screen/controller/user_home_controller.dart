import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  // Text Controllers
  final locationController = TextEditingController();
  final distanceController = TextEditingController();
  final messageController = TextEditingController();

  // Dropdown States
  var isCategoryExpanded = false.obs;
  var isSubCategoryExpanded = false.obs;

  // Selected Values
  var selectedCategory = "Category".obs;
  var selectedSubCategory = "Sub-Category".obs;

  // Sub-Categories Map
  final Map<String, List<String>> subCategories = {
    "Bar": ["Cocktail Bar", "Sports Bar", "Nightclub"],
    "Restaurants": ["Italian", "Chinese", "Mexican", "Indian"],
    "Salon": ["Hair Salon", "Nail Salon", "Spa"],
    "Cafe": ["Coffee Shop", "Bakery", "Tea House"],
    "Gym": ["Yoga", "CrossFit", "Cardio"],
    "Hotel": ["Luxury", "Budget", "Resort"],
    "Club": ["Dance Club", "Jazz Club", "Comedy Club"],
    "Library": ["Public Library", "University Library", "Digital Library"],
    "Mall": ["Shopping Mall", "Outlet Mall", "Plaza"]
  };

  // Toggle Category Dropdown
  void toggleCategoryExpanded() {
    isCategoryExpanded.toggle();
    if (isCategoryExpanded.isTrue) {
      isSubCategoryExpanded.value =
          false; // Close sub-category when category is expanded
    }
  }

  // Toggle Sub-Category Dropdown
  void toggleSubCategoryExpanded() {
    isSubCategoryExpanded.toggle();
  }

  // Select Category
  void selectCategory(String category) {
    selectedCategory.value = category;
    selectedSubCategory.value = "Sub-Category"; // Reset sub-category
    isCategoryExpanded.value = false;
  }

  // Select Sub-Category
  void selectSubCategory(String subCategory) {
    selectedSubCategory.value = subCategory;
    isSubCategoryExpanded.value = false;
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
    distanceController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
