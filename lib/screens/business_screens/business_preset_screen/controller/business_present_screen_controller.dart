import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/all_offers_model.dart';
import '../../../../services/repository/business_offer_repository/business_offer_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessPresetScreenController extends GetxController {
  final BusinessOfferRepository _businessOfferRepository =
      BusinessOfferRepository();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final RxInt discount = 0.obs;
  final RxBool isLoading = false.obs;

  final RxList<AllOffers> getAllOffers = <AllOffers>[].obs;
  final RxBool isLoadingOffers = false.obs;

  final Rx<AllOffers?> selectedOffer = Rx<AllOffers?>(null);
  RxInt selectedOfferIndex = (-1).obs; // -1 means nothing selected


  @override
  void onInit() {
    super.onInit();
    fetchAllOffers();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> postOffer({
    required String title,
    required String description,
    // required int discount,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      AppSnackBar.error("Please fill in all fields and select a discount.");
      return;
    }

    isLoading.value = true;
    try {
      bool success = await _businessOfferRepository.postOffer(
        title: title,
        description: description,
        // discount: discount,
      );

      if (success) {
        titleController.clear();
        descriptionController.clear();
        // this.discount.value = 0;
        await fetchAllOffers();
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllOffers() async {
    isLoadingOffers.value = true;
    try {
      List<AllOffers>? offersList =
          await _businessOfferRepository.getAllOffers();
      if (offersList != null) {
        getAllOffers.assignAll(offersList);
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred while fetching offers.");
    } finally {
      isLoadingOffers.value = false;
    }
  }

  Future<void> fetchOfferDetails(String offerId) async {
    isLoading.value = true;
    try {
      List<AllOffers>? fetchedOffers =
          await _businessOfferRepository.getAllOffers();
      if (fetchedOffers != null) {
        selectedOffer.value = fetchedOffers.firstWhere(
          (offer) => offer.id == offerId,
          // orElse: () => null,
        );
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while fetching offer details.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String description,
    // required int discount,
  }) async {
   /* if (title.isEmpty || description.isEmpty || discount == 0) {
      AppSnackBar.error("Please fill in all fields and select a discount.");
      return;
    }*/

    isLoading.value = true;
    try {
      bool success = await _businessOfferRepository.updateOffer(
        offerId: offerId,
        title: title,
        description: description,
        // discount: discount,
      );

      if (success) {
        await fetchAllOffers();
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteOffer(String offerId) async {
    isLoading.value = true;
    try {
      bool success = await _businessOfferRepository.deleteOffer(offerId);
      if (success) {
        await fetchAllOffers();
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while deleting the offer.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultOffer(String offerId, bool isDefault, int index) async {
    isLoading.value = true;
    try {
      bool success = await _businessOfferRepository.setDefaultOffer(offerId, isDefault);
      if (success) {
        // Step 1: Set all offers to default = false
        for (int i = 0; i < getAllOffers.length; i++) {
          getAllOffers[i] = getAllOffers[i].copyWith(datumDefault: false);
        }

        // Step 2: Set selected offer to default = true
        AllOffers selected = getAllOffers[index].copyWith(datumDefault: true);

        // Step 3: Remove it from current position
        getAllOffers.removeAt(index);

        // Step 4: Insert at top
        getAllOffers.insert(0, selected);

        update();
        AppSnackBar.success("Offer set as default.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while setting the default offer.");
    } finally {
      isLoading.value = false;
    }
  }

// Future<void> deleteAllOffers() async {
//   isLoading.value = true;
//   try {
//     bool success = await _businessOfferRepository.deleteAllOffers();
//     if (success) {
//       offers.clear();
//       AppSnackBar.success("All offers deleted successfully.");
//     }
//   } catch (e) {
//     AppSnackBar.error("An error occurred while deleting all offers.");
//   } finally {
//     isLoading.value = false;
//   }
// }
}
