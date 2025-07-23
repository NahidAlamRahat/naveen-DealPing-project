import 'package:deal_ping/models/category_model.dart';
import 'package:deal_ping/screens/support_screen/controller/support_base_controller.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:get/get.dart';
import '../../../services/repository/user_home_repository/user_home_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';


// Main Controller
class SupportController extends SupportBaseController {

  // Status tabs
  final List<String> changeStatus = ['Support Request', 'History'];
  int selectedStatusIndex = 0;

  // Main form fields
  final UserHomeRepository _repository = UserHomeRepository();



  // Computed property for available support types
  List<String> get availableSupportTypes {
    final selectedTypes = formSections.map((section) => section.selectedType.value).toList();
    return supportTypeList.where((type) => !selectedTypes.contains(type)).toList();
  }



  // Form management
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }


  // Status tab change handler
  void onStatusChange(int index) {
    selectedStatusIndex = index;
    appLog('Selected Status: ${changeStatus[selectedStatusIndex]}');
    update();
  }



  // Category and subcategory management
  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      categories.value = await _repository.fetchCategories();
      // DEBUG logs - could be removed in production
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

  // Helper to get subcategories
  List<SubCategory> getSubcategoriesFor(String categoryTitle) {
    final category = categories.firstWhereOrNull((cat) => cat.title == categoryTitle);
    return category?.subCategories ?? [];
  }

}