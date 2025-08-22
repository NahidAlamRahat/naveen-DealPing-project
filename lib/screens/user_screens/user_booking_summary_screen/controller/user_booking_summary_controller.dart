import 'package:deal_ping/models/booking_create_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/repository/booking_repository/booking_confirm_repository.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../user_chat_list_proposal_screen/controller.dart';

class UserBookingSummaryController extends GetxController {

  BookingConfirmRepository bookingConfirmRepository  = BookingConfirmRepository();
  // শুধু কোড রাখার জন্য
  // String? bookingCode;

  // এখানে রিসিভড মেসেজ রাখবো
  late ChatMessageResponseModel message;

  String? requestId;
  String? chatId;

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




  String? get cleanRequestId {
    if (requestId == null) return null;
    return requestId!.replaceAll(RegExp(r'[\[\]\s]'), '');
  }

  // Confirm Booking
  void confirmBooking() async {
    BookingCreateModel bookingCreateModel = BookingCreateModel(
      offerTitle: message.offerTitle ?? '',
      offerDescription: message.offerDescription ?? '',
      business: message.sender?.id ?? '',
      request: cleanRequestId ?? '',
      chat: chatId ?? '',
    );

    final bookingData = await bookingConfirmRepository.bookingCreate(bookingCreateModel);

    if (bookingData != null) {
      appLog("📌 Booking Code: ${bookingData.code}");

      AppSnackBar.success(
        bookingConfirmRepository.successfullyMessage ?? 'Successful!',
      );

      // Screen-এ argument হিসেবে পাঠানো
      await Get.toNamed(
        AppRoutes.userBookingSuccessfullScreen,
        arguments: bookingData, // পুরো model পাঠানো
      );
    } else {
      AppSnackBar.message('${bookingConfirmRepository.errorMessage}');
    }
  }



  @override
  void onInit() {
    super.onInit();

    // Argument receive as Map
    final args = Get.arguments as Map<String, dynamic>;

    // Extract values
    message = args["chatMessage"] as ChatMessageResponseModel;

    // requestId check -> যদি list আসে, তাহলে প্রথম element নাও
    var req = args["requestId"];
    if (req is List && req.isNotEmpty) {
      requestId = req.first.toString();   // String আকারে রাখলাম
    } else {
      requestId = req?.toString();        // String হলে সরাসরি
    }

    chatId = args["chatId"]?.toString();

    // Debug logs
    appLog("✅ Received Offer Title: ${message.offerTitle}");
    appLog("✅ Request ID (final): $requestId");
    appLog("✅ Chat ID: $chatId");
  }




}
