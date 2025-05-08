import 'package:deal_ping/services/api/api_delete_services.dart';
import 'package:deal_ping/services/api/api_patch_services.dart';

import '../../../constants/api_urls.dart';
import '../../../models/all_offers_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_get_services.dart';
import '../../api/api_post_services.dart';

class BusinessOfferRepository {
  final ApiPostServices _apiPostServices = ApiPostServices();
  final ApiGetServices _apiGetServices = ApiGetServices();
  final ApiPatchServices _apiPatchServices = ApiPatchServices();
  final ApiDeleteServices _apiDeleteServices = ApiDeleteServices();

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

  Future<bool> updateOffer({
    required String offerId,
    required String title,
    required String description,
    required int discount,
  }) async {
    try {
      var response = await _apiPatchServices.apiPatchServices(
        url: "${ApiUrls.updateOffer}$offerId",
        body: {
          "title": title,
          "description": description,
          "discount": discount,
        },
      );

      if (response != null) {
        AppSnackBar.success("Offer updated successfully.");
        return true;
      } else {
        AppSnackBar.error("Failed to update offer.");
        return false;
      }
    } catch (e) {
      errorLog("updateOffer error", e);
      AppSnackBar.error("An error occurred while updating the offer.");
      return false;
    }
  }

  Future<bool> deleteOffer(String offerId) async {
    try {
      var response = await _apiDeleteServices.apiDeleteServices(
        "${ApiUrls.deleteOffer}$offerId",
        statusCode: 200, // or 204, depending on your API
      );

      if (response != null) {
        AppSnackBar.success("Offer deleted successfully.");
        return true;
      } else {
        AppSnackBar.error("Failed to delete offer.");
        return false;
      }
    } catch (e) {
      errorLog("deleteOffer error", e);
      AppSnackBar.error("An error occurred while deleting the offer.");
      return false;
    }
  }

  // Future<bool> deleteAllOffers() async {
  //   try {
  //     var response = await _apiDeleteServices.apiDeleteServices(
  //       ApiUrls.deleteAllOffers,
  //       statusCode: 200, // or 204, depending on your API
  //     );
  //
  //     if (response != null) {
  //       AppSnackBar.success("All offers deleted successfully.");
  //       return true;
  //     } else {
  //       AppSnackBar.error("Failed to delete all offers.");
  //       return false;
  //     }
  //   } catch (e) {
  //     errorLog("deleteAllOffers error", e);
  //     AppSnackBar.error("An error occurred while deleting all offers.");
  //     return false;
  //   }
  // }

  Future<bool> setDefaultOffer(String offerId, bool isDefault) async {
    try {
      var response = await _apiPatchServices.apiPatchServices(
        url: "${ApiUrls.updateOffer}$offerId",
        body: {
          "default": isDefault,
        },
      );

      if (response != null) {
        AppSnackBar.success(
            isDefault ? "Offer set as default." : "Offer unset as default.");
        return true;
      } else {
        AppSnackBar.error("Failed to set default offer.");
        return false;
      }
    } catch (e) {
      errorLog("setDefaultOffer error", e);
      AppSnackBar.error("An error occurred while setting the default offer.");
      return false;
    }
  }
}
