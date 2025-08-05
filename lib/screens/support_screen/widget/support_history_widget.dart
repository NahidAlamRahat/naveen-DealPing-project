import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../user_screens/user_bookings_screen/controller/booking_list_api_caller.dart';

/*
class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingListController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              controller.getBookingList(); // Load more on scroll bottom
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.bookingList.length,
            itemBuilder: (context, index) {
              final booking = controller.bookingList[index];
              return BookingCard(
                title: booking.businessName,
                location: booking.createdAt,
                distance: booking.bookingCode ?? '', index: index,
              );
            },
          ),
        );
      },
    );
  }
}
*/


class PastBookings extends StatelessWidget {
  const PastBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingListController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              controller.getBookingList(); // Load more on scroll bottom
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.bookingList.length,
            itemBuilder: (context, index) {
              final booking = controller.bookingList[index];
              return BookingCard(
                index: index,
                title: booking.businessName,
                location: booking.createdAt,
                distance: booking.bookingCode ?? '',
                isPastBooking: true,
              );
            },
          ),
        );
      },
    );
  }
}


class BookingCard extends StatelessWidget {
  final String title, location, distance;
  final bool isPastBooking;
  final int index;

  const BookingCard({
    super.key,
    required this.index,
    required this.title,
    required this.location,
    required this.distance,
    this.isPastBooking = false,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.grey50,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.grey700,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  TextWidget(
                    text: location,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                  ),
                  const SpaceWidget(spaceHeight: 2),
                  TextWidget(
                    text: distance,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.green500,
                  ),
                ],
              ),
            ],
          ),
          isPastBooking
              ? const Icon(
            Icons.check,
            size: 24,
            color: AppColors.green500,
          )
              :
              const TextWidget(text: 'pending')

        ],
      ),
    );
  }
}
