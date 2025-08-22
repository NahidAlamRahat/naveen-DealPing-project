import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../models/category_model.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../utils/app_log/app_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class SelectCategoryAndSubCategory extends GetxController {
  final RxList<Category> categories = <Category>[].obs;

  // For single form section
  final RxString selectedCategory = "empty".obs;
  final RxString selectedCategoryId = 'empty'.obs;
  final RxList<String> selectedSubCategories = <String>[].obs;

  final RxBool isLoading = true.obs;

  final UserHomeRepository _repository = UserHomeRepository();

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load categories
  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      categories.value = await _repository.fetchCategories();

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

  // Get category ID from title
  String? getCategoryIdByTitle(String title) {
    final category = categories.firstWhereOrNull((cat) => cat.title == title);
    return category?.id;
  }

  // Get subcategories by category title
  List<SubCategory> getSubcategoriesFor(String categoryTitle) {
    final category = categories.firstWhereOrNull((cat) => cat.title == categoryTitle);
    return category?.subCategories ?? [];
  }

  // Select category (and reset subcategories)
  void selectCategory(String? value) {
    selectedCategory.value = value ?? "empty";
    selectedCategoryId.value = getCategoryIdByTitle(value ?? "") ?? "empty";
    selectedSubCategories.clear();
  }

  // Toggle subcategory selection
  void toggleSubCategory(String subCategoryId) {
    if (selectedSubCategories.contains(subCategoryId)) {
      selectedSubCategories.remove(subCategoryId);
    } else {
      selectedSubCategories.add(subCategoryId);
    }
  }

  // Validate current selection
  void validateSelection() {
    if (selectedCategory.value == "empty") {
      throw "Please select a category.";
    }

    final catId = getCategoryIdByTitle(selectedCategory.value);
    if (catId == null) {
      throw "Invalid category selected.";
    }

    if (selectedSubCategories.isEmpty) {
      throw "Please select at least one subcategory.";
    }

    // Logging
    appLog("Selected Category: ${selectedCategory.value} (ID: $catId)");
    final subTitles = getSubcategoriesFor(selectedCategory.value)
        .where((sub) => selectedSubCategories.contains(sub.id))
        .map((sub) => sub.title ?? 'Unknown')
        .toList();

    appLog("Selected Subcategories: ${subTitles.join(', ')}");
  }
}
