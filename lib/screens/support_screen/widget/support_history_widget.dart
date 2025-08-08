import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../constants/app_colors.dart';
import '../../../models/category_model.dart';
import '../../../models/support_history_model.dart' hide Category;
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../controller/support_history_controller.dart';
class SupportHistoryWidget extends StatelessWidget {
  const SupportHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SupportHistoryController>(
      init: SupportHistoryController(),
      builder: (controller) {
        // Loading state
        if (controller.isLoading.value && controller.supportHistoryModelList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Empty state
        if (!controller.isLoading.value && controller.supportHistoryModelList.isEmpty) {
          return const Center(child: Text("No support history found"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              if (!controller.isPagination.value && !controller.isLast) {
                controller.onDataLoad(); // Load more data
              }
            }
            return false;
          },
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.supportHistoryModelList.length +
                (controller.isPagination.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.supportHistoryModelList.length) {
                // Pagination loader
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final supportItem = controller.supportHistoryModelList[index];
              return BookingCard(
                index: index,
                title: "${supportItem.category?.title} > ${supportItem.prevCategory?.title}",
                location: supportItem.createdAt ?? "",
                distance: supportItem.status ?? '',
                status: supportItem.status ?? 'pending',
                subcategories: supportItem.subcategories,
              );
            },
          ),
        );
      },
    );
  }
}


class BookingCard extends StatelessWidget {
  final String title, location, distance, status;
  final bool isPastBooking;
  final int index;
  final Category? category;
  final Category? prevCategory;
  final List<Subcategory>? subcategories;
  final String? businessName;
  final String? eiin;

  const BookingCard({
    super.key,
    required this.index,
    required this.title,
    required this.location,
    required this.distance,
    required this.status,
    this.isPastBooking = false,
    this.category,
    this.prevCategory,
    this.subcategories,
    this.businessName,
    this.eiin,
  });

  @override
  Widget build(BuildContext context) {
    List<String> displayTitle = [];

    // Dynamically add titles based on available data
    if (category != null) displayTitle.add("Category: ${category?.title}");
    if (prevCategory != null) displayTitle.add("Prev Category: ${prevCategory?.title}");
    if (businessName != null) displayTitle.add("Business Name: $businessName");
    if (eiin != null) displayTitle.add("EIIN: $eiin");
    if (subcategories != null && subcategories!.isNotEmpty) {
      displayTitle.add("Subcategories: ");
      displayTitle.addAll(subcategories!.map((subcategory) => subcategory.title ?? "").toList());
    }

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE (Title information, dynamically filled)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (Display the titles as per the available data)
                TextWidget(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                ),
                const SpaceWidget(spaceHeight: 4),

                // Location (Created at date)
                TextWidget(
                  text: location,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey700,
                ),
                const SpaceWidget(spaceHeight: 4),

                // Dynamically display the different available data (Category, Business Name, EIIN, Subcategories)
                ...displayTitle.map((text) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextWidget(
                      text: text,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.grey700,
                    ),
                  );
                }).toList(),

                const SpaceWidget(spaceHeight: 8),

                // Status (Distance, or Pending Status)
                TextWidget(
                  text: distance,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.green500,
                ),
              ],
            ),
          ),

          // RIGHT SIDE (Status)
          const SizedBox(width: 8),
          Center(
            child: TextWidget(
              text: status,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontColor: status.toLowerCase() == 'pending'
                  ? Colors.orange
                  : AppColors.green500,
            ),
          ),
        ],
      ),
    );
  }
}


