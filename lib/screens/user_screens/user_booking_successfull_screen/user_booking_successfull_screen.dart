import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/models/booking_create_responce_model.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserBookingSuccessFullScreen extends StatelessWidget {


   UserBookingSuccessFullScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    // final BookingListController bookingController = Get.put(BookingListController());
    var apiResponce = Get.arguments as BookingResponseModel;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: '',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SpaceWidget(spaceHeight: 0),
            Column(
              children: [
                const ImageWidget(
                  imagePath: AppImagePath.bookingSuccessfulImage,
                  height: 150,
                  width: 150,
                ),
                const SpaceWidget(spaceHeight: 20),
                const TextWidget(
                  text: AppStrings.bookingSuccessful,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.green500,
                ),
                const SpaceWidget(spaceHeight: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: AppStrings.bookingId,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.grey700,
                    ),
                    TextWidget(
                      text:apiResponce.code,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.grey700,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ButtonWidget(
                  onPressed: () {
                    Get.toNamed(AppRoutes.barcodeScreen, arguments: apiResponce  );
                  },
                  label: AppStrings.viewBarcode,
                  buttonWidth: double.infinity,
                ),
                const SpaceWidget(spaceHeight: 12),
                ButtonWidget(
                  onPressed: () {
                    Get.toNamed(AppRoutes.userBookingsScreen);
                  },
                  label: AppStrings.viewBookings,
                  buttonWidth: double.infinity,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.grey300,
                  borderColor: AppColors.grey300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






class BarcodeScreen extends StatelessWidget {
  // final BookingListController bookingController = Get.put(BookingListController());


  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final index = Get.arguments;
    // if (index == null || index is! int) {
    //   return const Center(child: Text("Invalid booking index"));
    // }

    final  responce = Get.arguments as BookingResponseModel;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        text: AppStrings.barcode,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
          color: AppColors.green500,
        ),
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
                    text: 'You have successfully reserved your Service! '
                        'Please scan the barcode to proceed with your request '
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
                    leftValue: responce.business.name,
                    rightValue: responce.offerTitle,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Service Name',
                    rightLabel: 'Type of Service',
                    leftValue: responce.category.title,
                    rightValue: responce.subCategories.toString(),
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel:'Location',
                    rightLabel: 'Date',
                    leftValue: responce.business.address,
                    rightValue: (DateTime.tryParse(responce.createdAt.toString()) ?? DateTime.now()).date,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Time',
                    leftValue: (DateTime.tryParse(responce.createdAt.toString()) ?? DateTime.now()).time,
                  ),
                  const SpaceWidget(spaceHeight: 36),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Order code: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey300,
                            ),
                          ),
                          TextSpan(
                            text:responce.code,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
    );
  }



  Widget _buildDetailRow({
    String? leftLabel,
    String? rightLabel,
    String? leftValue,
    String? rightValue,
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
                  text: leftLabel ?? '',
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
                  text: leftValue ?? '',
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
                  text: rightLabel ?? '',
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
                  text: rightValue ?? '',
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