import '../../../constants/api_urls.dart';
import '../../../models/all_offers_model.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_services.dart';

class BusinessOfferRepository {
  Future<bool> postOffer({
    required String title,
    required String description,
    // required int discount,
  }) async {
    try {
     var response = await ApiService.postApi(
        ApiUrls.createOffer,
        {
          "title": title,
          "description": description,
          // "discount": discount,
        },
      );

      AppSnackBar.success(response.message);
      return true;
        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while posting the offer.");
      return false;
    }
  }

  Future<List<AllOffers>?> getAllOffers() async {
    try {
      var response = await ApiService.getApi(ApiUrls.getAllOffer);
      final List<dynamic> offersJson = response.body['data'] ?? [];
      return offersJson
          .map((json) => AllOffers.fromJson(json))
          .toList();

        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while fetching offers.");
      return null;
    }
  }

  Future<bool> updateOffer({
    required String offerId,
    required String title,
    required String description,
    // required int discount,
  }) async {
    try {
      await ApiService.patchApi(
        "${ApiUrls.updateOffer}$offerId",
        body: {
          "title": title,
          "description": description,
          // "discount": discount,
        },
      );

      AppSnackBar.success("Offer updated successfully.");
      return true;
        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while updating the offer.");
      return false;
    }
  }

  Future<bool> deleteOffer(String offerId) async {
    try {
      await ApiService.deleteApi(
        "${ApiUrls.deleteOffer}$offerId",
      );

      AppSnackBar.success("Offer deleted successfully.");
      return true;
        } catch (e) {
      errorLog(e);
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
       await ApiService.patchApi(
        "${ApiUrls.updateOffer}$offerId",
        body: {
          "default": isDefault,
        },
      );

      AppSnackBar.success(
          isDefault ? "Offer set as default." : "Offer unset as default.");
      return true;
        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while setting the default offer.");
      return false;
    }
  }
}
