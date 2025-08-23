
import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/appbar_widget/appbar_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/space_widget/space_widget.dart';
import 'controller/user_barcode_controller.dart';

class UserBarcodeScreen extends StatelessWidget {
  final UserBarcodeController controller = Get.put(UserBarcodeController());
  // final BookingListController bookingController = Get.put(BookingListController());

  UserBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
                    leftValue: controller.bookingModel?.businessName??'',
                    rightValue: controller.bookingModel?.offerTitle,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Service Name',
                    rightLabel: 'Type of Service',
                    leftValue: controller.bookingModel?.categoryTitle,
                    rightValue: controller.bookingModel?.subCategories.toString(),
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel:'Location',
                    rightLabel: 'Date',
                    leftValue: controller.bookingModel?.address,
                    rightValue: (DateTime.tryParse(controller.bookingModel!.createdAt.toString()) ?? DateTime.now()).date,
                  ),
                  const SpaceWidget(spaceHeight: 14),
                  _buildDetailRow(
                    leftLabel: 'Time',
                    leftValue: (DateTime.tryParse(controller.bookingModel!.createdAt.toString()) ?? DateTime.now()).time,
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
                            text: controller.bookingModel?.bookingCode,
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
