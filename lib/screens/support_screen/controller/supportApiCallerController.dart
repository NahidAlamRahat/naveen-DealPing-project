import 'package:collection/collection.dart';
import 'package:deal_ping/screens/support_screen/controller/request_api_caller.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import '../model/request_model.dart';
import '../model/support_category.dart';

class SupportFormSection {
  final RxString selectedType = ''.obs;
  final RxString selectedCategory = "empty".obs;
  final RxList<String> selectedSubCategories = <String>[].obs;
  final TextEditingController problemController = TextEditingController();
  final TextEditingController inputFieldController = TextEditingController();

  final RxString selectedCategoryId = 'empty'.obs;  // Now stores ID instead of title
// final RxList<String> selectedSubCategoryIds = <String>[].obs; // Stores subcategory IDs



// Add any other form-specific fields you need
}

class SupportRequestController extends GetxController {
// Status tabs
  final List<String> changeStatus = ['Support Request', 'History'];
  int selectedStatusIndex = 0;

// Main form fields
  final TextEditingController writeProblemTEController = TextEditingController();
  final UserHomeRepository _repository = UserHomeRepository();
  final RequestApiController _requestApiController = Get.put(RequestApiController());
// RxList<SupportSubCategoryModel> selectedSubCategories = <SupportSubCategoryModel>[].obs;

// Support type options
  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Business Name',
    'Eiin Number',
    'Other',

  ];

  List<String> get availableSupportTypes {
    final selectedTypes = formSections.map((section) => section.selectedType.value).toList();
    return supportTypeList.where((type) => !selectedTypes.contains(type)).toList();
  }

  bool get canAddMoreSections {
    // Count non-empty selected types
    final selectedTypes = formSections
        .map((s) => s.selectedType.value)
        .where((v) => v.isNotEmpty)
        .toList();

    return selectedTypes.length < supportTypeList.length;
  }


// Form management
  RxList<SupportFormSection> formSections = <SupportFormSection>[SupportFormSection()].obs;

  RxList<SupportCategory> categories = <SupportCategory>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onClose() {
    writeProblemTEController.dispose();
    for (var section in formSections) {
      section.problemController.dispose();
      section.inputFieldController.dispose();
    }
    super.onClose();
  }

// Status tab change
  void onStatusChange(int index) {
    selectedStatusIndex = index;
    appLog('Selected Status: ${changeStatus[selectedStatusIndex]}');
    update();
  }

// Form section management
  void addFormSection() {
    formSections.add(SupportFormSection());
  }

  void removeFormSection(int index) {
    if (formSections.length > 1) {
      formSections[index].problemController.dispose();
      formSections.removeAt(index);
    }
  }

// Category and subcategory management
  void fetchCategories() async {
    isLoading.value = true;
    try {
      var response = await _repository.fetchCategories();

      categories.value = response.map((item) => SupportCategory(
        id: item.id ?? "",
        title: item.title ?? "",
        subCategories: item.subCategories?.map((e) => e.title ?? '').toList() ?? [],
      )).toList();

      // Log the category data for debugging
      appLog("=====>>😎😍😍😎😎(❁´◡❁)(●'◡'●)😎😎😎++  ${categories.value = response.map((item) => SupportCategory(
        id: item.id ?? "",
        title: item.title ?? "",
        subCategories: item.subCategories?.map((e) => e.title ?? '').toList() ?? [],
      )).toList()} ");


      for (var category in categories) {
        appLog("Category ID(●'◡'●)(❁´◡❁): ${category.id}, Category Title: ${category.title}");
        appLog("Subcategories: ${category.subCategories}");
      }

    } catch (e) {
      AppSnackBar.error("Failed to load categories");
    } finally {
      isLoading.value = false;
    }
  }



  List<String> getSubcategoriesFor(String categoryTitle) {
    final category = categories.firstWhereOrNull((cat) => cat.title == categoryTitle);

    return category?.subCategories ?? [];
  }

// Helper methods for form sections
  void setFormSectionType(int index, String value) {
    formSections[index].selectedType.value = value;
    appLog('sections👌👌👌===>>${    formSections[index].selectedType.value = value}');

    // Reset dependent fields when type changes
    formSections[index].selectedCategory.value = "empty";

    formSections[index].selectedSubCategories.clear();

  }

  void setFormSectionCategory(int index, String value) {
    formSections[index].selectedCategory.value = value;
    appLog('selectedCategory ❤️❤️===>>${formSections[index].selectedCategory.value = value}');

    formSections[index].selectedSubCategories.clear();
  }

/*  void toggleFormSectionSubCategory(int index, String subCategoryId) {
    if (formSections[index].selectedSubCategories.contains(subCategoryId)) {
      formSections[index].selectedSubCategories.remove(subCategoryId);
    } else {
      formSections[index].selectedSubCategories.add(subCategoryId);

      appLog('sub Category toggle👌👌👌===>>${formSections[index].selectedSubCategories.contains(subCategoryId)}');
    }
  }*/

  void toggleFormSectionSubCategory(int index, String subCategoryId) {
    if (formSections[index].selectedSubCategories.contains(subCategoryId)) {
      formSections[index].selectedSubCategories.remove(subCategoryId);
    } else {
      formSections[index].selectedSubCategories.add(subCategoryId);
    }
  }




// Helper method to get category ID by category title
  String? _getCategoryIdByTitle(String title) {
    // Find the category by title and return its ID
    final category = categories.firstWhereOrNull((cat) => cat.title == title);

    // Log to check if category is found and its ID
    appLog('Category found for title "$title": ${category?.id}'); // Logging the category ID

    return category?.id; // Return the ID associated with the title
  }


  String? getSubCategoryIdByTitle(String categoryTitle, String subCategoryTitle) {
    final category = categories.firstWhereOrNull((cat) => cat.title == categoryTitle);

    if (category == null) return null;

    final matched = _subCategoryObjectsFor(categoryTitle)
        .firstWhereOrNull((subCat) => subCat.title == subCategoryTitle);

    return matched?.id;
  }

  List<SupportSubCategoryModel> _subCategoryObjectsFor(String categoryTitle) {
    final category = categories.firstWhereOrNull((cat) => cat.title == categoryTitle);
    return category != null
        ? category.subCategories.map((e) => SupportSubCategoryModel.fromJson({'_id': '', 'title': e})).toList()
        : [];
  }



  Future<void> onTapSubmitSupportRequests() async {
    try {
      // Step 1: Validate all form sections
      for (int i = 0; i < formSections.length; i++) {
        final section = formSections[i];

        if (section.selectedType.value.isEmpty) {
          throw "Section ${i + 1}: Please select a support type.";
        }

        if (section.problemController.text.trim().isEmpty) {
          throw "Section ${i + 1}: Please describe your problem.";
        }
      }

      // Step 2: Convert each form section to model and send to API
      for (var section in formSections) {
        String? categoryId;
        List<String>? subCategoryList;

        // Get category ID based on the selected category title
        if (section.selectedCategory.value != "empty") {
          categoryId = _getCategoryIdByTitle(section.selectedCategory.value);
        }

        subCategoryList = section.selectedSubCategories.isNotEmpty
            ? section.selectedSubCategories
            : null;

        // Log to check if categoryId is fetched correctly
        appLog('Selected Category ID: $categoryId');

        // Check if the categoryId is valid
        if (categoryId == null) {
          throw "Invalid Category ID: ${section.selectedCategory.value}";
        }

        SupportRequestModel model = SupportRequestModel(
          category: categoryId, // Use the category ID here
          subcategories: subCategoryList,
          businessName:
          section.selectedType.value == 'Business Name' ? section.problemController.text.trim() : null,
          eiin: section.selectedType.value == 'Eiin Number' ? section.problemController.text.trim() : null,
        );

        // Log the model data to check if it’s correct before submitting
        appLog("Submitting model: ${model.toJson()}");

        // TODO: call your repository API here, for example:
        await _requestApiController.sentRequest(model.toJson());
      }

      AppSnackBar.success('${_requestApiController.successfullyMessage}');
      appLog('Submission Success: ${_requestApiController.successfullyMessage}');

      // Optionally clear all sections
      formSections.value = [SupportFormSection()];
    } catch (e) {
      AppSnackBar.error(e.toString());
      appLog('Error: $e');
    }
  }






}

