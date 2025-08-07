import 'package:deal_ping/screens/support_screen/controller/request_api_caller.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../utils/app_log/app_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../model/request_model.dart';
import '../widget/support_form_section.dart';

class SupportBaseController extends GetxController{

  RxList<SupportFormSection> formSections = <SupportFormSection>[SupportFormSection()].obs;
  final RequestApiController _requestApiController = Get.put(RequestApiController());
  RxList<Category> categories = <Category>[].obs;


  // Support type options
  final List<String> supportTypeList = [
    'Changed Category Name',
    'Change Sub Category Name',
    'Business Name',
    'Eiin Number',
    'Other',
  ];

  // Form section management
  void addFormSection() {
    if (canAddMoreSections) {  // Added validation
      formSections.add(SupportFormSection());
    }
  }


  RxList<Map<String, String>> profileSubCategoryList = <Map<String, String>>[].obs;


  subCategoryShow() {
    final args = Get.arguments;
    if (args != null && args['subcategories'] != null) {
      final List<dynamic> subCatMap = args['subcategories'];
      profileSubCategoryList.value = subCatMap.map((e) {
        final id = e['id']?.toString() ?? '';
        final title = e['title']?.toString() ?? '';
        return {
          'id': id,
          'title': title,
        };
      }).toList();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    subCategoryShow();
    super.onInit();
  }


  // Validation for adding more sections
  bool get canAddMoreSections {
    final selectedTypes = formSections
        .map((s) => s.selectedType.value)
        .where((v) => v.isNotEmpty)
        .toList();
    return selectedTypes.length < supportTypeList.length;
  }

  void removeFormSection(int index) {
    if (formSections.length > 1) {
      formSections[index].dispose();  // Use dispose method
      formSections.removeAt(index);
    }
  }

  // Form section setters
  void setFormSectionType(int index, String value) {
    formSections[index].selectedType.value = value;

    // Reset dependent fields
    formSections[index].selectedCategory.value = "empty";
    formSections[index].selectedSubCategories.clear();
  }

  void setFormSectionCategory(int index, String value) {
    formSections[index].selectedCategory.value = value;
    formSections[index].selectedSubCategories.clear();
  }

  void setFormSectionSubCategory(int index, String value) {
    formSections[index].selectedSubCategories.clear();
    formSections[index].selectedSubCategories.add(value);
  }

  void toggleFormSectionSubCategory(int index, String subCategoryId) {
    if (formSections[index].selectedSubCategories.contains(subCategoryId)) {
      formSections[index].selectedSubCategories.remove(subCategoryId);
    } else {
      formSections[index].selectedSubCategories.add(subCategoryId);
    }
  }


  // Helper to get category ID by title
  String? _getCategoryIdByTitle(String title) {
    final category = categories.firstWhereOrNull((cat) => cat.title == title);
    appLog('Category found for title "$title": ${category?.id}');
    return category?.id;
  }


  /// Support Request Submission Logic

  Future<void> onTapSubmitSupportRequests() async {
    try {
      // Validate all sections
      for (int i = 0; i < formSections.length; i++) {
        final section = formSections[i];
        if (section.selectedType.value.isEmpty) {
          throw "Section ${i + 1}: Please select a support type.";
        }
        if (section.problemController.text.trim().isEmpty) {
          throw "Section ${i + 1}: Please describe your problem.";
        }
      }

      // Process each section
      for (var section in formSections) {
        String? categoryId;
        List<String>? subCategoryList;

        // If support type is NOT "Change Sub Category Name", set categoryId normally
        if (section.selectedType.value != "Change Sub Category Name" &&
            section.selectedCategory.value != "empty") {
          categoryId = _getCategoryIdByTitle(section.selectedCategory.value);
          if (categoryId == null) {
            throw "Invalid Category ID: ${section.selectedCategory.value}";
          }
        }

        // Always send subcategories if any selected
        subCategoryList = section.selectedSubCategories.isNotEmpty
            ? section.selectedSubCategories
            : null;

        SupportRequestModel model = SupportRequestModel(
          category: categoryId,  // will be null if support type is "Change Sub Category Name"
          subcategories: subCategoryList,
          businessName: section.selectedType.value == 'Business Name'
              ? section.problemController.text.trim()
              : null,
          eiin: section.selectedType.value == 'Eiin Number'
              ? section.problemController.text.trim()
              : null,
        );

        // Debug prints to check what is sent to API
        appLog('Sending SupportRequestModel to API:');
        appLog('Support Type: ${section.selectedType.value}');
        appLog('Category ID: $categoryId');
        appLog('Subcategory IDs: $subCategoryList');
        appLog('Business Name: ${model.businessName}');
        appLog('Eiin Number: ${model.eiin}');

        await _requestApiController.sentRequest(model.toJson());
      }

      AppSnackBar.success('${_requestApiController.successfullyMessage}');
      formSections.value = [SupportFormSection()]; // Reset form
    } catch (e) {
      AppSnackBar.error(e.toString());
      appLog('Error: $e');
    }
  }




}