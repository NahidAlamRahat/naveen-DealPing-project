import '../../../constants/api_urls.dart';
import '../../../models/all_offers_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_get_services.dart';
import '../../api/api_post_services.dart';

class BusinessOfferRepository {
  final ApiPostServices _apiPostServices = ApiPostServices();
  final ApiGetServices _apiGetServices = ApiGetServices();

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

  Future<List<AllOffers>?> fetchAllOffers() async {
    try {
      var response = await _apiGetServices.apiGetServices(ApiUrls.getAllOffer);
      print("API Response: $response"); // Debug log
      if (response != null) {
        Welcome offersData = Welcome.fromJson(response);
        return offersData.data;
      } else {
        AppSnackBar.error("Failed to fetch offers.");
        return null;
      }
    } catch (e) {
      errorLog("fetchAllOffers error", e);
      AppSnackBar.error("An error occurred while fetching offers.");
      return null;
    }
  }
}
