import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../user_bookings_screen/controller/booking_list_api_caller.dart';

class UserBookingSuccessFullScreen extends StatelessWidget {


   UserBookingSuccessFullScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    // final BookingListController bookingController = Get.put(BookingListController());
    var apiResponce = Get.arguments;

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
                      text: apiResponce.toString(),
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
                    Get.toNamed(AppRoutes.userBarcodeScreen,);
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
