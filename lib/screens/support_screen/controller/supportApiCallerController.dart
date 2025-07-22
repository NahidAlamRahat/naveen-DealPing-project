import 'package:deal_ping/screens/support_screen/controller/request_api_caller.dart';
import 'package:deal_ping/screens/support_screen/controller/sub_category_api_caller.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import '../model/request_model.dart';
import '../model/support_category.dart';
import '../widget/formfild.dart';


/*class SupportRequestController extends GetxController {

  List<String> changeStatus = [
    'Support Request',
    'History'

  ];

  final TextEditingController writeProblemTEController = TextEditingController();
  final UserHomeRepository _repository = UserHomeRepository();

  RxString selectedSupportType = ''.obs;
  RxString selectedCategory = "empty".obs;
  RxString selectedSubCategory = "empty".obs;
  final selectedSubCategoryId = ''.obs;
  int selectedStatusIndex = 0;


  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Business Name',
    'Eiin Number',
    'Other',

  ];

  RxList<SupportFormSection> additionalForms = <SupportFormSection>[].obs;

  void onStatusChange(int index) {
    selectedStatusIndex = index;
    appLog('==== Selected Status ===>>>> ${changeStatus[selectedStatusIndex]}');
    update(); // GetBuilder update trigger
  }



  void setSupportType(String value) {
  selectedSupportType.value = value;
  }

  void setAdditionalFormType(int index, String value) {
  additionalForms[index].selectedType.value = value;
  }

  void addFormSection() {
  additionalForms.add(SupportFormSection());
  }


  void removeFormSection(int index) {
    additionalForms.removeAt(index);
  }



}*/


//============================================

///error solve


/*
class SupportRequestController extends GetxController {

  List<String> changeStatus = [
    'Support Request',
    'History'

  ];


  // final SubCategoryApiController subCategoryController = Get.put(SubCategoryApiController());

  final TextEditingController writeProblemTEController = TextEditingController();

  final UserHomeRepository _repository = UserHomeRepository();

  RxList<SupportFormSection> additionalForms = <SupportFormSection>[].obs;


  RxString selectedSupportType = ''.obs;
  RxString selectedCategory = "empty".obs;
  RxString selectedSubCategory = "empty".obs;
  final selectedSubCategoryId = ''.obs;
  int selectedStatusIndex = 0;
  RxList<String> selectedSubCategories = <String>[].obs;


  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Other',
  ];

  RxList<SupportCategory> categories = <SupportCategory>[].obs;
  RxBool isLoading = true.obs;



  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }


  RxList<int> formSectionIds = <int>[].obs;
  final RxInt _idCounter = 0.obs;
  final Map<int, TextEditingController> dynamicControllers = {};

  // void addFormSection() {
  //   formSectionIds.add(_formIdCounter++);
  // }

  void onStatusChange(int index) {
    selectedStatusIndex = index;
    appLog('==== Selected Status ===>>>> ${changeStatus[selectedStatusIndex]}');
    update(); // GetBuilder update trigger
  }





  void setAdditionalFormType(int index, String value) {
    additionalForms[index].selectedSupportType = value;
  }

  void addFormSection() {
    int newId = _idCounter.value++;
    formSectionIds.add(newId);
    dynamicControllers[newId] = TextEditingController();
    update();
  }

  TextEditingController? getControllerById(int id) {
    return dynamicControllers[id];
  }

  void removeFormSection(int index) {
    additionalForms.removeAt(index);
  }


  void toggleSubCategory(String subCategory) {
    if (selectedSubCategories.contains(subCategory)) {
      selectedSubCategories.remove(subCategory);
    } else {
      selectedSubCategories.add(subCategory);
    }
    update();
  }


  void fetchCategories() async {
    isLoading.value = true;
    try {
      var response = await _repository.fetchCategories();

      List<SupportCategory> fetchedCategories = [];

      for (var item in response) {
        final List<String> subCats = item.subCategories?.map((e) => e.title ?? '').toList() ?? [];

        fetchedCategories.add(SupportCategory(
          id: item.id ?? "",
          title: item.title ?? "",
          subCategories: subCats,
        ));
      }

      categories.value = fetchedCategories;
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  List<String> get selectedCategorySubcategories {
    final category = categories.firstWhereOrNull(
            (cat) => cat.title == selectedCategory.value);
    return category?.subCategories ?? [];
  }






  void setCategory(String value) async {
    selectedCategory.value = value;
    selectedSubCategory.value = "empty"; // Reset subcategory

    final selected = categories.firstWhereOrNull((cat) => cat.title == value);
    if (selected != null) {
      // await subCategoryController.getSubCategory(); // fetch subcategories
    }

    update();
  }




  void setSubCategory(String subCategoryTitle) {
    selectedSubCategory.value = subCategoryTitle;

    final category = categories.firstWhere(
          (cat) => cat.title == selectedCategory.value,
    );

    update();
  }

  void setSupportType(String value) {
    selectedSupportType.value = value;
    update();
  }


  @override
  void onClose() {
    writeProblemTEController.dispose();
    for (var controller in dynamicControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

}
*/


class SupportFormSection {
  final RxString selectedType = ''.obs;
  final RxString selectedCategory = "empty".obs;
  final RxList<String> selectedSubCategories = <String>[].obs;
  final TextEditingController problemController = TextEditingController();
  final TextEditingController inputFieldController = TextEditingController();

  final RxString selectedCategoryId = 'empty'.obs;  // Now stores ID instead of title
  final RxList<String> selectedSubCategoryIds = <String>[].obs; // Stores subcategory IDs



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
RxList<SupportSubCategoryModel> selectedSubCategories = <SupportSubCategoryModel>[].obs;

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


/*  bool get canAddMoreSections {
    final selectedTypes = formSections.map((s) => s.selectedType.value).toList();
    return supportTypeList.length > selectedTypes.where((e) => e.isNotEmpty).length;
  }*/

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
      appLog("Fetched Categories: ");
      for (var category in categories) {
        appLog("Category ID: ${category.id}, Category Title: ${category.title}");
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

  void toggleFormSectionSubCategory(int index, String subCategoryId) {
    if (formSections[index].selectedSubCategories.contains(subCategoryId)) {
      formSections[index].selectedSubCategories.remove(subCategoryId);
    } else {
      formSections[index].selectedSubCategories.add(subCategoryId);
    }
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
        String? categoryId =
        section.selectedCategory.value != "empty" ? section.selectedCategory.value : null;
        List<String>? subCategoryList = section.selectedSubCategories.isNotEmpty
            ? section.selectedSubCategories
            : null;

        // Debug log to check if category and subcategories are IDs
        appLog('Submitting Section: ${section.selectedType.value}');
        appLog('Category ID: $categoryId');
        appLog('Subcategory IDs: $subCategoryList');

        SupportRequestModel model = SupportRequestModel(
          category: categoryId,
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




// Submit all forms
/*
  Future<void> submitAllForms() async {
    try {
      // Validate all forms first
      for (var section in formSections) {
        if (section.selectedType.isEmpty) {
          throw "Please select a support type for all sections";
        }
        if (section.problemController.text.isEmpty) {
          throw "Please describe your problem in all sections";
        }
        // Add any other validation rules
      }

      // Process each form section
      for (var section in formSections) {
        final data = {
          'type': section.selectedType.value,
          'category': section.selectedCategory.value,
          'subcategories': section.selectedSubCategories.join(', '),
          'problem': section.problemController.text,
        };
        appLog('Submitting form data: $data');
        // Here you would typically send the data to your API
        // await _repository.submitSupportRequest(data);
      }

      AppSnackBar.success("Support requests submitted successfully");
      // Optionally clear forms after successful submission
      // formSections.value = [SupportFormSection()];
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }
*/




}

