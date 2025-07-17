import 'package:deal_ping/services/api/api_services.dart';

import '../../../constants/api_urls.dart';
import '../../../models/faq_model.dart';
import '../../../models/terms_and_conditions_model.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class CommonRepository {
  Future<List<FAQData>?> fetchFAQs() async {
    try {
      var response = await ApiService.getApi(ApiUrls.faq);
      FAQ faqData = FAQ.fromJson(response.body);
      return faqData.data;
        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while fetching FAQs.");
      return null;
    }
  }


  Future<StaticPageModel?> fetchTermsAndConditions() async {
    try {
      final response = await ApiService.getApi(
        ApiUrls.termsAndCondition,
      );
      return StaticPageModel.fromJson(response.body);
        } catch (e) {
      // AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
      return null;
    }
  }


  Future<StaticPageModel?> fetchAboutUs() async {
    try {
      final response = await ApiService.getApi(
        ApiUrls.about,
      );
      return StaticPageModel.fromJson(response.body);
        } catch (e) {
      AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
      return null;
    }
  }

}
