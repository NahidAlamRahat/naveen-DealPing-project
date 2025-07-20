import 'package:deal_ping/screens/user_screens/user_home_screen/controller/sent_request_api_caller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/category_model.dart';
import '../../../../models/sent_home_screen_data_model.dart';
import '../../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserHomeController extends GetxController {
  final UserHomeRepository _repository = UserHomeRepository();
  final SentRequestController _sentRequestController =
      Get.put(SentRequestController());

  // Text Controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  double currentValue = 5.0;

  List<double> latLong = [90.4045442, 23.7935446];

  var isLoading = false.obs;
  RxList<Category> categories = <Category>[].obs;
  var subCategories = <String>[].obs;

  // Selected Values
  var selectedCategory = "empty".obs; // Initially empty (no selection)
  final selectedCategoryId = ''.obs;
  var selectedSubCategory = "empty".obs; // Initially empty (no selection)
  final selectedSubCategoryId = ''.obs;
  var subCategoryMap = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();

  }



  void fetchCategories() async {
    isLoading.value = true;
    try {
      categories.value = await _repository.fetchCategories();
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  // Select Category

  void selectCategory(String categoryTitle) {
    selectedCategory.value = categoryTitle;
    selectedSubCategory.value = "";

    final selectedCategoryData = categories.firstWhere(
      (cat) => cat.title == categoryTitle,
      orElse: () => Category(),

    );

    selectedCategoryId.value = selectedCategoryData.id ?? '';

    // Update the subcategories list
    subCategories.value = selectedCategoryData.subCategories
            ?.map((subCategory) => subCategory.title ?? "")
            .toList() ??
        [];
  }

  void selectSubCategory(String subCategoryTitle) {
    selectedSubCategory.value = subCategoryTitle;

    final category = categories.firstWhere(
      (cat) => cat.title == selectedCategory.value,
      orElse: () => Category(),
    );

    final subCategory = category.subCategories?.firstWhere(
      (sub) => sub.title == subCategoryTitle,
      orElse: () =>SubCategory (),
    );

    selectedSubCategoryId.value = subCategory?.id ?? '';
  }

  // Navigate to Location Screen
  void navigateToLocationScreen() async {
    final selectedLocation = await Get.toNamed('/userLocationScreen');
    if (selectedLocation != null) {
      locationController.text = selectedLocation;
    }
  }

  Future<void> onTapRequestButton() async {
    // model call
    RequestModel requestModel = RequestModel(
        message: messageController.text.trim(),
        radius: currentValue,
        category: selectedCategoryId.value,
        subCategories: [selectedSubCategoryId.value],
        coordinates: latLong);

    final bool isSuccess =
        await _sentRequestController.createRequest(requestModel);
    _sentRequestController.signUpInProgress == true;

    if (isSuccess) {
      _sentRequestController.signUpInProgress == false;

      AppSnackBar.success(
          _sentRequestController.successfullyMessage ?? 'Successful!');
      appLog('success message => ${_sentRequestController.successfullyMessage}');

    } else {
      _sentRequestController.signUpInProgress == false;
      // error message
      AppSnackBar.message('${_sentRequestController.errorMessage}');
      appLog('error message => ${_sentRequestController.errorMessage}');
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
