/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportRequestController extends GetxController {
  final TextEditingController writeProblemTEController = TextEditingController();

  String selectedSupportType = '';
  String selectedSubCategoryType = '';

  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Other',
  ];

  final List<String> subCategoryTypeList = [
    'dhaka',
    'feni',
    'Other',
  ];

  // This variable will determine whether the subCategory dropdown should be shown
  bool showSubCategoryDropdown = false;

  void setSupportType(String value) {
    selectedSupportType = value;
    showSubCategoryDropdown = value == 'Changed Category Name' || value == 'Change Sub Category Name';
    selectedSubCategoryType = ''; // Reset selected subcategory when support type changes
    update(); // Triggers GetBuilder update
  }

  void subCategoryType(String value) {
    selectedSubCategoryType = value;
    update(); // Triggers GetBuilder update
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../model/model.dart';





class SupportRequestController extends GetxController {
  final TextEditingController writeProblemTEController = TextEditingController();

  final UserHomeRepository _repository = UserHomeRepository();

  String selectedSupportType = '';
  String selectedCategory = "empty";
  String selectedSubCategory = "empty";

  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Other',
  ];

  var isLoading = false.obs;
  var categories = <SupportCategory>[].obs;  // List of categories
  var subCategories = <String>[].obs;  // List of subcategories for the selected category

  final selectedCategoryId = ''.obs;  // ID of the selected category
  final selectedSubCategoryId = ''.obs;  // ID of the selected subcategory

  @override
  void onInit() {
    super.onInit();
    fetchCategories();  // Fetch categories when the controller is initialized
  }

  // Fetch categories and their subcategories from the repository
  void fetchCategories() async {
    isLoading.value = true;
    try {
      final categoryResponse = await _repository.fetchCategories();
      debugPrint('=============categoryResponse...😂😢😊😎👌🤣😥😥?>>>>>>>>>>>>>>>>>${categories.value}');

      if (categoryResponse != null && categoryResponse.success == true) {
        // Mapping the data from response to SupportCategory model
        categories.value = categoryResponse.data?.map((item) => SupportCategory.fromJson(item as Map<String, dynamic>)).toList() ?? [];
        debugPrint('=============...😂😢😊😎👌🤣😥😥?>>>>>>>>>>>>>>>>>${categories.value}');

      } else {
        AppSnackBar.error(categoryResponse?.message ?? "Failed to load categories.");
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }



  // Set the selected category
  void setCategory(String categoryTitle) {
    selectedCategory = categoryTitle;
    debugPrint('=============.selectedCategory.title😂😢😊😎👌🤣😥😥?>>>>>>>>>>>>>>>>>$selectedCategory');

    selectedSubCategory = "empty";  // Reset subcategory when category changes

    final selectedCategoryData = categories.firstWhere(
          (cat) => cat.title == categoryTitle,
      orElse: () => SupportCategory(id: '', title: '', subCategories: []),
    );

    selectedCategoryId.value = selectedCategoryData.id;
    subCategories.value = selectedCategoryData.subCategories
        .map((subCategory) => subCategory.title)
        .toList();

    debugPrint('=============.selectedCategoryId.value😂😢😊😎👌🤣😥😥?>>>>>>>>>>>>>>>>>${selectedCategoryId.value}');
    debugPrint('=============.subCategories.valu😂😢😊😎👌🤣😥😥?>>>>>>>>>>>>>>>>>${subCategories.value}');

    update();  // Trigger UI update
  }

  // Set the selected subcategory
  void setSubCategory(String subCategoryTitle) {
    selectedSubCategory = subCategoryTitle;

    final category = categories.firstWhere(
          (cat) => cat.title == selectedCategory,
      orElse: () => SupportCategory(id: '', title: '', subCategories: []),
    );

    final subCategory = category.subCategories.firstWhere(
          (sub) => sub.title == subCategoryTitle,
      orElse: () => SubCategory(id: '', title: ''),
    );

    selectedSubCategoryId.value = subCategory.id;
    update();  // Trigger UI update
  }

  // Handle support type selection
  void setSupportType(String value) {
    selectedSupportType = value;
    update();  // Trigger UI update
  }
}

