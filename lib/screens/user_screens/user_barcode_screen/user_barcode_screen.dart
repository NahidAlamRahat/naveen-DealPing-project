import 'package:barcode_widget/barcode_widget.dart';
import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/appbar_widget/appbar_widget.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import 'controller/user_barcode_controller.dart';

class UserBarcodeScreen extends StatelessWidget {
  final UserBarcodeController controller = Get.put(UserBarcodeController());

  UserBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarWidget(
        text: AppStrings.barcode,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.green50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Hi there,',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const TextWidget(
                    text: 'You have successfully reserved your Service!'
                        'Please scan the barcode to proceed with your request'
                        'and access the service seamlessly.',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),
                  const SpaceWidget(spaceHeight: 24),
                  _buildDetailRow(
                    leftLabel: 'Name',
                    rightLabel: 'Offer',
                    leftValue: controller.name.value,
                    rightValue: controller.offer.value,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Service Name',
                    rightLabel: 'Number of People',
                    leftValue: controller.serviceName.value,
                    rightValue:
                        controller.numberOfPeople.toString().padLeft(2, '0'),
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Type of Service',
                    rightLabel: 'Date',
                    leftValue: controller.typeOfService.value,
                    rightValue: controller.formattedDate.value,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Location',
                    rightLabel: 'Time',
                    leftValue: controller.location.value,
                    rightValue: controller.formattedTime.value,
                  ),
                  const SpaceWidget(spaceHeight: 36),
                  Obx(() => Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: controller.barcodeNumber.value,
                            width: 200,
                            height: 100,
                            drawText: true,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ),
                      )),
                  const SpaceWidget(spaceHeight: 36),
                  const TextWidget(
                    text: 'Thanks & Regards\nDealPing',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ButtonWidget(
          onPressed: () {
            showCustomPopup(
              context,
              [
                const SpaceWidget(spaceHeight: 34),
                const TextWidget(
                  text: AppStrings.areYouSure,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                  textAlignment: TextAlign.center,
                ),
                const SpaceWidget(spaceHeight: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      label: AppStrings.no,
                      onPressed: () => Navigator.pop(context),
                      buttonHeight: 36,
                      buttonWidth: 71,
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.red,
                      textColor: AppColors.red,
                      fontSize: 12,
                    ),
                    const SpaceWidget(spaceWidth: 24),
                    ButtonWidget(
                      label: AppStrings.yes,
                      onPressed: () => Navigator.pop(context),
                      buttonHeight: 36,
                      buttonWidth: 71,
                      backgroundColor: AppColors.red,
                      textColor: AppColors.white,
                      fontSize: 12,
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 24),
              ],
            );
          },
          backgroundColor: AppColors.red.withAlpha(70),
          label: AppStrings.cancelBooking,
          buttonHeight: 52,
          buttonWidth: double.infinity,
          fontSize: 16,
          textColor: AppColors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String leftLabel,
    required String rightLabel,
    required String leftValue,
    required String rightValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 220,
                child: TextWidget(
                  text: leftLabel,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey300,
                  textAlignment: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 220,
                child: TextWidget(
                  text: leftValue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                  textAlignment: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SpaceWidget(spaceWidth: 24),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: TextWidget(
                  text: rightLabel,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey300,
                  textAlignment: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 200,
                child: TextWidget(
                  text: rightValue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                  textAlignment: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
