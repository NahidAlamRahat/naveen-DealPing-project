import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/booking_list_api_caller.dart';

class UserBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BookingListController(),
      builder: (BookingListController controller) {
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.green50,
                  ),
                  child: TabBar(
                    indicatorColor: AppColors.green500,
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.green500,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: controller.onBookingStatusChange,
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
              ),
            ),
            body: const TabBarView(
              children: [
                BookingsList(), // For ongoing bookings
                PastBookings(), // For dummy past bookings
              ],
            ),
          ),
        );
      },
    );
  }
}

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingListController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookingList.isEmpty) {
          return const Center(child: Text("No bookings found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            final booking = controller.bookingList[index];
            return BookingCard(
              title: booking.businessName,
              location: booking.address,
              distance: "${booking.distance.toStringAsFixed(2)} miles",
              networkImageUrl:
                  '${AppImagePath.imageUrl}${booking.userProfileImage}' ?? '',
              rating: booking.rating ?? 0,
            );
          },
        );
      },
    );
  }
}

class PastBookings extends StatelessWidget {
  const PastBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingListController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookingList.isEmpty) {
          return const Center(child: Text("No bookings found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: controller.bookingList.length,
          itemBuilder: (context, index) {
            final booking = controller.bookingList[index];
            return BookingCard(
              title: booking.businessName,
              location: booking.address,
              distance: "${booking.distance.toStringAsFixed(2)} miles",
              networkImageUrl:
                  '${AppImagePath.imageUrl}${booking.userProfileImage}' ?? '',
              isPastBooking: true,
              rating: booking.rating ?? 0,
            );
          },
        );
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final String title, location, distance, networkImageUrl;
  final bool isPastBooking;
  final rating;

  const BookingCard({
    super.key,
    required this.title,
    required this.location,
    required this.distance,
    required this.networkImageUrl,
    this.isPastBooking = false,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    print("Image URL:❤️❤️❤️❤️❤️ $networkImageUrl");
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
          /// LEFT SIDE (Image + Texts)
          Expanded(
            // ✅ fix: wrap with Expanded
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: NetworkImageWidget(
                    networkImageUrl: networkImageUrl,
                    width: AppSize.width(value: 99),
                    height: AppSize.width(value: 59),
                  ),
                ),
                const SpaceWidget(spaceWidth: 6),
                Expanded(
                  // ✅ wrap the Column to avoid internal overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: title,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.grey700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SpaceWidget(spaceHeight: 4),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < rating.floor()) {
                            return const Icon(Icons.star,
                                color: AppColors.yellow, size: 12);
                          } else if (index < rating && rating % 1 >= 0.5) {
                            return const Icon(Icons.star_half,
                                color: AppColors.yellow, size: 12);
                          } else {
                            return const Icon(Icons.star_border,
                                color: AppColors.yellow, size: 12);
                          }
                        }),
                      ),
                      const SpaceWidget(spaceHeight: 2),
                      TextWidget(
                        text: location,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.grey700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                ),
              ],
            ),
          ),

          /// RIGHT SIDE (Button or Icon)
          isPastBooking
              ? const Icon(
                  Icons.check,
                  size: 24,
                  color: AppColors.green500,
                )
              : ButtonWidget(
                  onPressed: () {
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
