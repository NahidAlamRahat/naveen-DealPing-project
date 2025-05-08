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
  final RxInt discount = 0.obs; // To track the selected discount percentage
  final RxBool isLoading = false.obs;

  final RxList<AllOffers> offers = <AllOffers>[].obs;
  final RxBool isLoadingOffers = false.obs;

  // Post Offer
  Future<void> postOffer() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        discount.value == 0) {
      AppSnackBar.error("Please fill in all fields and select a discount.");
      return;
    }

    isLoading.value = true;
    try {
      bool success = await _businessOfferRepository.postOffer(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        discount: discount.value,
      );

      if (success) {
        // Clear fields after successful submission
        titleController.clear();
        descriptionController.clear();
        discount.value = 0;
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred.");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch All Offers
  Future<void> fetchAllOffers() async {
    isLoadingOffers.value = true;
    try {
      List<AllOffers>? fetchedOffers =
          await _businessOfferRepository.fetchAllOffers();
      if (fetchedOffers != null) {
        offers.assignAll(fetchedOffers);
      }
    } catch (e) {
      AppSnackBar.error("An unexpected error occurred while fetching offers.");
    } finally {
      isLoadingOffers.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllOffers(); // Fetch offers when the controller is initialized
  }
}
