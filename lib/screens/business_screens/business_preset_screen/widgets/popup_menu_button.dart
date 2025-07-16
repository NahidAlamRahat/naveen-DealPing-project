/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'offer_button.dart';

PopupMenuButton<int> PopupMenuButtonWidget(BuildContext context) {
  return PopupMenuButton<int>(
    onSelected: (value) {
      if (value == 1) {
        showCustomPopup(
          context,
          [
            const Center(
              child: TextWidget(
                text: AppStrings.setDefault,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.grey700,
                textAlignment: TextAlign.center,
              ),
            ),
            const SpaceWidget(spaceHeight: 11),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: 'Title',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.green500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grey300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.green500),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: 'Description',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.green500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grey300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.green500),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (BuildContext context,
                  StateSetter setState) {
                return Column(
                  children: [
                    buildOfferButton(
                            (selectedPercentage) {
                          setState(() {
                            _selectedPercentage =
                                selectedPercentage;
                            controller.discount.value =
                                selectedPercentage;
                          });
                        }),

                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        ButtonWidget(
                          label: AppStrings.add,
                          onPressed: () {
                            if (controller.discount.value ==
                                0) {
                              AppSnackBar.error(
                                  "Please select a discount percentage.");
                              return;
                            }
                            controller.postOffer(
                              title: titleController.text
                                  .trim(),
                              description:
                              descriptionController.text
                                  .trim(),
                              discount:
                              controller.discount.value,
                            );
                            Get.back();
                          },
                          buttonHeight: 36,
                          buttonWidth: 90,
                          backgroundColor:
                          AppColors.green500,
                          textColor: AppColors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        );
      } else if (value == 2) {
        // Implement delete all offers
        //controller.deleteAllOffers();
      }
    },
    itemBuilder: (context) => [
      const PopupMenuItem(
        value: 1,
        child: Text(
          "Set New Offer",
          style: TextStyle(
              fontSize: 14, color: AppColors.grey700),
        ),
      ),
      const PopupMenuDivider(height: 0.5),
      const PopupMenuItem(
        value: 2,
        child: Text(
          "Delete all Offers",
          style: TextStyle(
              fontSize: 14, color: AppColors.grey700),
        ),
      ),
    ],
    offset: const Offset(0, 40),
    color: AppColors.white,
    elevation: 2,
  );
}
*/
