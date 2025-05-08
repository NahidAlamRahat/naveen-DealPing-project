import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/repository/business_offer_repository/business_offer_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessPresetScreenController extends GetxController {
  final BusinessOfferRepository _businessOfferRepository =
      BusinessOfferRepository();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxInt discount = 0.obs; // To track the selected discount percentage
  final RxBool isLoading = false.obs;

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
}
