import 'package:deal_ping/screens/support_screen/controller/sub_category_api_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import '../model/support_category.dart';




class SupportRequestController extends GetxController {
  final SubCategoryApiController subCategoryController = Get.put(SubCategoryApiController());

  final TextEditingController writeProblemTEController = TextEditingController();
  final UserHomeRepository _repository = UserHomeRepository();

  RxString selectedSupportType = ''.obs;
  RxString selectedCategory = "empty".obs;
  RxString selectedSubCategory = "empty".obs;
  final selectedSubCategoryId = ''.obs;

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



  void fetchCategories() async {
    isLoading.value = true;
    try {
      var response = await _repository.fetchCategories();
      List<SupportCategory> fetchedCategories = [];

      for (var item in response) {
        final subCategory = item.subCategories;
        if (subCategory != null) {
        }

        fetchedCategories.add(SupportCategory(
          id: item.id ?? "",
          title: item.title ?? "",
        ));

      }

      categories.value = fetchedCategories;
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }



  void setCategory(String value) async {
    selectedCategory.value = value;
    selectedSubCategory.value = "empty"; // Reset subcategory

    final selected = categories.firstWhereOrNull((cat) => cat.title == value);
    if (selected != null) {
      await subCategoryController.getSubCategory(); // fetch subcategories
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

}
