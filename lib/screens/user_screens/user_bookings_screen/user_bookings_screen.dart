import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const TextWidget(
            text: AppStrings.bookings,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.grey700,
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.green50),
              child: TabBar(
                indicatorColor: AppColors.green500,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.green500,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.green500,
                  borderRadius: BorderRadius.circular(4),
                ),
                tabs: const [
                  Tab(text: AppStrings.ongoingBookings),
                  Tab(text: AppStrings.pastBookings),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 8),
            Expanded(
              child: TabBarView(
                children: [
                  BookingsList(),
                  PastBookings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingsList extends StatelessWidget {
  final List<Map<String, String>> bookings = List.generate(
      5,
      (index) => {
            'title': 'Mirchi Dance Bar',
            'location': 'Dhanmondi, Dhaka',
            'distance': '2.3 miles',
            'image': AppImagePath.bookingsImage,
          });

  BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(
          title: booking['title']!,
          location: booking['location']!,
          distance: booking['distance']!,
          imagePath: booking['image']!,
        );
      },
    );
  }
}

class PastBookings extends StatelessWidget {
  final List<Map<String, String>> bookings = List.generate(
      5,
      (index) => {
            'title': 'Mirchi Dance Bar',
            'location': 'Dhanmondi, Dhaka',
            'distance': '2.3 miles',
            'image': AppImagePath.bookingsImage,
          });

  PastBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(
          title: booking['title']!,
          location: booking['location']!,
          distance: booking['distance']!,
          imagePath: booking['image']!,
          isPastBooking: true,
        );
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final String title, location, distance, imagePath;
  final bool isPastBooking;

  const BookingCard({
    super.key,
    required this.title,
    required this.location,
    required this.distance,
    required this.imagePath,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageWidget(
                  imagePath: imagePath,
                  width: 99,
                  height: 59,
                ),
              ),
              const SpaceWidget(spaceWidth: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.grey700,
                  ),
                  const SpaceWidget(spaceHeight: 4),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                        size: 12,
                      ),
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 2),
                  TextWidget(
                    text: location,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.grey700,
                  ),
                  const SpaceWidget(spaceHeight: 2),
                  Row(
                    children: [
                      const IconWidget(
                        icon: AppIconsPath.locationIcon2,
                        width: 12,
                        height: 12,
                      ),
                      const SpaceWidget(spaceWidth: 4),
                      TextWidget(
                        text: distance,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.grey700,
                      ),
                    ],
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
              : ButtonWidget(
                  onPressed: () {
                    // View Booking
                    Get.toNamed(AppRoutes.userBarcodeScreen);
                  },
                  label: AppStrings.view,
                  buttonHeight: 36,
                  buttonWidth: 72,
                  fontSize: 12,
                ),
        ],
      ),
    );
  }
}
