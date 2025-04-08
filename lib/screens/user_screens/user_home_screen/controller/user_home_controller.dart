import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_image_path.dart';

class UserHomeController extends GetxController {
  // Text Controllers
  final locationController = TextEditingController();
  final distanceController = TextEditingController();
  final messageController = TextEditingController();

  // Selected Values
  var selectedCategory = "".obs; // Initially empty (no selection)
  var selectedSubCategory = "".obs; // Initially empty (no selection)

  // Sub-Categories Map
  final Map<String, List<String>> subCategories = {
    "Bar": ["Cocktail Bar", "Sports Bar", "Nightclub"],
    "Restaurant": ["Italian", "Chinese", "Mexican", "Indian"],
    "Salon": ["Hair Salon", "Nail Salon", "Spa"],
    "Paint": ["Building", "Mall", "Stadium"],
    "Spa": ["Massage", "Facial", "Therapy"],
  };

  // Category Icons Map
  final Map<String, String> categoryIcons = {
    "Bar": AppImagePath.barIcon,
    "Restaurant": AppImagePath.restaurantIcon,
    "Salon": AppImagePath.salonIcon,
    "Paint": AppImagePath.paintIcon,
    "Spa": AppImagePath.spaIcon,
  };

  @override
  void onInit() {
    super.onInit();
    // No default selection
  }

  // Select Category
  void selectCategory(String category) {
    selectedCategory.value = category;
    selectedSubCategory.value = ""; // Reset subcategory when category changes
  }

  // Select Sub-Category
  void selectSubCategory(String subCategory) {
    if (selectedCategory.value.isNotEmpty) {
      // Only allow if a category is selected
      selectedSubCategory.value = subCategory;
    }
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
