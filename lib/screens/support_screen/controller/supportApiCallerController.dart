import 'package:deal_ping/screens/support_screen/controller/sub_category_api_caller.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import '../model/support_category.dart';


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
    additionalForms[index].selectedType.value = value;
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
