import 'package:get/get.dart';

import '../../../models/faq_model.dart';
import '../../../services/repository/common_repository/common_repository.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class FAQScreenController extends GetxController {
  final CommonRepository _commonRepository = CommonRepository();

  final RxList<FAQData> faqs = <FAQData>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }

  Future<void> fetchFAQs() async {
    isLoading.value = true;
    try {
      List<FAQData>? fetchedFAQs = await _commonRepository.fetchFAQs();
      if (fetchedFAQs != null) {
        faqs.assignAll(fetchedFAQs);
      }
    } catch (e) {
      // AppSnackBar.error("An error occurred while fetching FAQs.");
    } finally {
      isLoading.value = false;
    }
  }
}
