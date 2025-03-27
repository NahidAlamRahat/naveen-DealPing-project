import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class BusinessBookingsScreen extends StatelessWidget {
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
            'title': 'John Doe',
            'location': '22 January, 2025||04:00 PM',
            'distance': '#263487',
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
        );
      },
    );
  }
}

class PastBookings extends StatelessWidget {
  final List<Map<String, String>> bookings = List.generate(
      5,
      (index) => {
            'title': 'John Doe',
            'location': '22 January, 2025||04:00 PM',
            'distance': '#263487',
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
          isPastBooking: true,
        );
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final String title, location, distance;
  final bool isPastBooking;

  const BookingCard({
    super.key,
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
              : ButtonWidget(
                  onPressed: () {},
                  label: AppStrings.checkIn,
                  buttonHeight: 36,
                  buttonWidth: 90,
                  fontSize: 12,
                ),
        ],
      ),
    );
  }
}
