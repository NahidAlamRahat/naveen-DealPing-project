import 'package:deal_ping/models/booking_create_model.dart';
import 'package:deal_ping/screens/user_screens/user_bookings_screen/controller/booking_list_api_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/repository/booking_repository/booking_confirm_repository.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../user_chat_list_proposal_screen/controller.dart';
import '../../user_profile_screen/controller/user_profile_controller.dart';

class UserBookingSummaryController extends GetxController {

  BookingConfirmRepository bookingConfirmRepository  = BookingConfirmRepository();
  // শুধু কোড রাখার জন্য
  String? bookingCode;

  // এখানে রিসিভড মেসেজ রাখবো
  late ChatMessageResponseModel message;

  // Date and Time Selection
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 10, minute: 0).obs;

  // Expandable Sections
  final RxBool isDateExpanded = false.obs;
  final RxBool isTimeExpanded = false.obs;

  // Number of People
  final RxInt numberOfPeople = 4.obs;

  // Fixed list of dates starting from the current date
  List<DateTime> get availableDates => List.generate(
        15,
        (index) => DateTime.now().add(Duration(days: index)),
      );

  // Fixed list of times starting from 10:00 AM
  List<TimeOfDay> get availableTimes => List.generate(
        15,
        (index) => TimeOfDay(hour: 10 + index, minute: 0),
      );

  // Toggle Date Expansion
  void toggleDateExpansion() {
    isDateExpanded.value = !isDateExpanded.value;
  }

  // Select Date
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Toggle Time Expansion
  void toggleTimeExpansion() {
    isTimeExpanded.value = !isTimeExpanded.value;
  }

  // Select Time
  void selectTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  // Increment People Count
  void incrementPeople() {
    numberOfPeople.value++;
  }

  // Decrement People Count
  void decrementPeople() {
    if (numberOfPeople.value > 1) {
      numberOfPeople.value--;
    }
  }



  ChatController chatController = ChatController();





  // Confirm Booking
  void confirmBooking() async {
    BookingCreateModel bookingCreateModel = BookingCreateModel(
      offerTitle: message.offerTitle!,
      offerDescription: message.offerDescription!,
      category: message.sender?.category ?? 'category null',
      subCategories: ['686c9a44dad115a94f52bbcc'],
      business: message.sender!.id.toString(),
      request: message.id!,
    );

    final responseData = await bookingConfirmRepository.bookingCreate(bookingCreateModel);

    if (responseData != null && responseData['code'] != null) {
      String bookingCode = responseData['code'];
      appLog("📌 Booking Code: $bookingCode");

      AppSnackBar.success(
        bookingConfirmRepository.successfullyMessage ?? 'Successful!',
      );

    } else {
      AppSnackBar.message('${bookingConfirmRepository.errorMessage}');
    }
  }


  @override
  void onInit() {
    super.onInit();

    // Argument receive + type casting
    message = Get.arguments as ChatMessageResponseModel;

    appLog("✅ Received Offer Title: ${message.offerTitle}");
    appLog("✅ Received Offer Description: ${message.offerDescription}");
    appLog("✅ Sender Name: ${message.sender?.name}");
    appLog("✅ Request ID: ${message.id}");
    appLog("✅ Sender ID: ${message.sender?.id}");
    appLog("✅ Category : ${message.sender?.category}");
  }

}
