import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/screens/user_screens/user_chat_screen/controller/user_chate_controller.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/repository/booking_repository/booking_confirm_repository.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../user_chat_list_proposal_screen/controller.dart';
import 'controller/user_booking_summary_controller.dart';

class UserBookingSummaryScreen extends StatelessWidget {
  UserBookingSummaryScreen({super.key });

  final UserBookingSummaryController bBontroller =
      Get.put(UserBookingSummaryController());

  UserChatController controller = Get.find<UserChatController>();
  ChatController chatController = Get.put(ChatController());
  BookingConfirmRepository bookingConfirmRepository = Get.put(BookingConfirmRepository());


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.summary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bar Info Card\

              // const BookingCardWidget(
              //
              //   imagePath: AppImagePath.bookingsImage,
              //   title: 'Mirchi Dance Ba',
              //   location: 'Dhanmondi, Dhaka',
              //   distance: '2.3 miles',
              //   starCount: 5,
              // ),
              const SpaceWidget(spaceHeight: 16),

              // User Info
              _buildInfoRow('Name', bBontroller.message.sender?.name ?? '--'),
              const SpaceWidget(spaceHeight: 12),
              _buildInfoRow('E-mail',bBontroller.message.sender?.email ?? '--'),
              // const SpaceWidget(spaceHeight: 12),
              // _buildInfoRow('Phone', controller.chatMessagesList[0].sender!.phone.toString()),
              const SpaceWidget(spaceHeight: 12),
              _buildInfoRow('Location',bBontroller.message.sender?.address ?? '--'),
              const SpaceWidget(spaceHeight: 12),
              _buildInfoRow('Bar Type',bBontroller.message.sender?.category ?? '--'),

              // const Divider(height: 30, color: AppColors.grey300),
              const SpaceWidget(spaceHeight: 6),

              /// Date Selection
              // _buildDateSelection(),

              const SpaceWidget(spaceHeight: 20),

              /// Time Selection
              // _buildTimeSelection(),

              const SpaceWidget(spaceHeight: 12),

              /// People Counter
              // _buildPeopleCounter(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ButtonWidget(
          onPressed: () {
           bBontroller.confirmBooking();
          },
          backgroundColor: AppColors.green500,
          label: AppStrings.confirmYourBooking,
          buttonHeight: 52,
          buttonWidth: double.infinity,
          fontSize: 16,
          textColor: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.grey700,
        ),
        TextWidget(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.grey700,
        ),
      ],
    );
  }

 /* // Date Selection Widget
  Widget _buildDateSelection() {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  text: 'Booking for',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey700,
                ),
                GestureDetector(
                  onTap: controller.toggleDateExpansion,
                  child: Row(
                    children: [
                      const Text(
                        AppStrings.selectADate,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SpaceWidget(spaceWidth: 1),
                      Icon(
                        controller.isDateExpanded.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: AppColors.grey700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (controller.isDateExpanded.value) ...[
              const SpaceWidget(spaceHeight: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.availableDates.length,
                    (index) {
                      final date = controller.availableDates[index];
                      final isSelected = date.day ==
                              controller.selectedDate.value.day &&
                          date.month == controller.selectedDate.value.month &&
                          date.year == controller.selectedDate.value.year;
                      return GestureDetector(
                        onTap: () => controller.selectDate(date),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.green500
                                      : AppColors.white,
                                ),
                                child: Text(
                                  DateFormat('dd').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.grey700,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('EEE').format(date),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey700,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ));
  }

  // Time Selection Widget
  Widget _buildTimeSelection() {
    return Obx(() => Column(
          children: [
            GestureDetector(
              onTap: controller.toggleTimeExpansion,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    AppStrings.selectATime,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SpaceWidget(spaceWidth: 1),
                  Icon(
                    controller.isTimeExpanded.value
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: AppColors.grey700,
                  ),
                ],
              ),
            ),
            if (controller.isTimeExpanded.value) ...[
              const SpaceWidget(spaceHeight: 10),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                  controller.availableTimes.length,
                  (index) {
                    final time = controller.availableTimes[index];
                    final isSelected =
                        time.hour == controller.selectedTime.value.hour &&
                            time.minute == controller.selectedTime.value.minute;
                    return GestureDetector(
                      onTap: () => controller.selectTime(time),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppColors.green500 : AppColors.white,
                          border: Border.all(color: AppColors.green500),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          time.format(Get.context!),
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.grey700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ));
  }

  // People Counter Widget
  Widget _buildPeopleCounter() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'People',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.grey700,
              ),
            ),
            Row(
              children: [
                IconButton(
                  splashRadius: 0.0001,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    maxWidth: 10,
                  ),
                  onPressed: controller.decrementPeople,
                  icon: const Icon(
                    Icons.remove_circle,
                    color: AppColors.green500,
                    size: 22,
                  ),
                ),
                Text(
                  controller.numberOfPeople.value.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey700,
                  ),
                ),
                IconButton(
                  splashRadius: 0.0001,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 10, maxWidth: 10),
                  onPressed: controller.incrementPeople,
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppColors.green500,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ));
  }*/



}
