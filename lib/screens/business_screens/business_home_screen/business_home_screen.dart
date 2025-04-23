import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({super.key});

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  List<Map<String, dynamic>> messages = List.generate(
      5,
      (index) => {
            "name": "John Doe",
            "message": "Hi! I'd love to book a table for 4 tonight.",
            "time": "01:42",
            "unread": 2,
            "image": AppImagePath.profileImage,
          });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceWidget(spaceHeight: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                text: "Hello, Cafe Rio!",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.grey700,
                textAlignment: TextAlign.start,
              ),
            ),
            const SpaceWidget(spaceHeight: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                text:
                    "Boost your bookings and attract more customers with limited-time deals!",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
            ),
            const SpaceWidget(spaceHeight: 10),
            const SpaceWidget(spaceHeight: 16),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.green50),
              child: TabBar(
                indicatorColor: AppColors.green500,
                labelColor: AppColors.white,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                unselectedLabelColor: AppColors.green500,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.green500,
                  borderRadius: BorderRadius.circular(4),
                ),
                tabs: const [
                  Tab(
                    // text: "New\nmessage",
                    child: Text(
                      "New",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Tab(
                    // text: "New\nmessage",
                    child: Text(
                      "Ongoing",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Tab(
                    // text: "New\nmessage",
                    child: Text(
                      "Confirmed",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Your message",
                  hintStyle: const TextStyle(
                    color: AppColors.grey300,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: AppColors.grey300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.grey300),
                  ),
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(messages.length, (index) {
                          var msg = messages[index];

                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.businessChatScreen);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.only(
                                  bottom: 12, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ImageWidget(
                                          imagePath: msg['image'],
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      const SpaceWidget(spaceWidth: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: msg['name'],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontColor: AppColors.green500,
                                          ),
                                          TextWidget(
                                            text: msg['message'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.grey700,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (msg['unread'] > 0)
                                        CircleAvatar(
                                          radius: 9,
                                          backgroundColor: AppColors.redisPink,
                                          child: TextWidget(
                                            text: msg['unread'].toString(),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                      const SpaceWidget(spaceHeight: 2),
                                      TextWidget(
                                        text: msg['time'],
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontColor: AppColors.grey300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(messages.length, (index) {
                          var msg = messages[index];

                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.businessChatScreen);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.only(
                                  bottom: 12, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ImageWidget(
                                          imagePath: msg['image'],
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      const SpaceWidget(spaceWidth: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: msg['name'],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontColor: AppColors.green500,
                                          ),
                                          TextWidget(
                                            text: msg['message'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.grey700,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (msg['unread'] > 0)
                                        CircleAvatar(
                                          radius: 9,
                                          backgroundColor: AppColors.redisPink,
                                          child: TextWidget(
                                            text: msg['unread'].toString(),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                      const SpaceWidget(spaceHeight: 2),
                                      TextWidget(
                                        text: msg['time'],
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontColor: AppColors.grey300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(messages.length, (index) {
                          var msg = messages[index];

                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.businessChatScreen);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.only(
                                  bottom: 12, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ImageWidget(
                                          imagePath: msg['image'],
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      const SpaceWidget(spaceWidth: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: msg['name'],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontColor: AppColors.green500,
                                          ),
                                          TextWidget(
                                            text: msg['message'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.grey700,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (msg['unread'] > 0)
                                        CircleAvatar(
                                          radius: 9,
                                          backgroundColor: AppColors.redisPink,
                                          child: TextWidget(
                                            text: msg['unread'].toString(),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                      const SpaceWidget(spaceHeight: 2),
                                      TextWidget(
                                        text: msg['time'],
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontColor: AppColors.grey300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
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
                  onPressed: () {},
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
