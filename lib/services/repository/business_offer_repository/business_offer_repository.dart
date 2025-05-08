import '../../../constants/api_urls.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_post_services.dart';

class BusinessOfferRepository {
  final ApiPostServices _apiPostServices = ApiPostServices();

  Future<bool> postOffer({
    required String title,
    required String description,
    required int discount,
  }) async {
    try {
      var response = await _apiPostServices.apiPostServices(
        url: ApiUrls.createOffer,
        body: {
          "title": title,
          "description": description,
          "discount": discount,
        },
      );

      if (response != null) {
        AppSnackBar.success("Offer posted successfully.");
        return true;
      } else {
        AppSnackBar.error("Failed to post offer.");
        return false;
      }
    } catch (e) {
      errorLog("postOffer error", e);
      AppSnackBar.error("An error occurred while posting the offer.");
      return false;
    }
  }
}
