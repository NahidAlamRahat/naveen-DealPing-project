import '../../../constants/api_urls.dart';
import '../../../models/faq_model.dart';
import '../../../models/terms_and_conditions_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_get_services.dart';

class CommonRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<List<FAQData>?> fetchFAQs() async {
    try {
      var response = await _apiGetServices.apiGetServices(ApiUrls.faq);
      if (response != null) {
        FAQ faqData = FAQ.fromJson(response);
        return faqData.data;
      } else {
        AppSnackBar.error("Failed to fetch FAQs.");
        return null;
      }
    } catch (e) {
      errorLog("fetchFAQs error", e);
      AppSnackBar.error("An error occurred while fetching FAQs.");
      return null;
    }
  }

  Future<TermsAndConditions?> fetchTermsAndConditions() async {
    try {
      final response = await _apiGetServices.apiGetServices(
        ApiUrls.termsAndCondition,
      );
      if (response != null) {
        return TermsAndConditions.fromJson(response);
      } else {
        AppSnackBar.error("Failed to fetch terms and conditions");
        return null;
      }
    } catch (e) {
      AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
      return null;
    }
  }
}
