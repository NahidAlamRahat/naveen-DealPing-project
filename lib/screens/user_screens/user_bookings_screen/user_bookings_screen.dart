import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:flutter/material.dart';

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
                  BookingsList(),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
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

class BookingCard extends StatelessWidget {
  final String title, location, distance, imagePath;

  const BookingCard({
    required this.title,
    required this.location,
    required this.distance,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.grey50,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ImageWidget(
            imagePath: imagePath,
            width: 99,
            height: 59,
          ),
        ),
        title: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5,
                  (index) => Icon(Icons.star, color: Colors.yellow, size: 14)),
            ),
            Text(location, style: TextStyle(fontSize: 12)),
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                Text(distance, style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text('View', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
