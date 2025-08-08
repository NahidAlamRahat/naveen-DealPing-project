import 'package:deal_ping/models/booking_create_model.dart';
import 'package:deal_ping/screens/user_screens/user_bookings_screen/controller/booking_list_api_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/repository/booking_repository/booking_confirm_repository.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../user_chat_list_proposal_screen/controller.dart';
import '../../user_profile_screen/controller/user_profile_controller.dart';

class UserBookingSummaryController extends GetxController {

  BookingConfirmRepository bookingConfirmRepository  = BookingConfirmRepository();

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
  void confirmBooking() async{
    appLog("Request ID: ${chatController.request.value?.requestId}");

    BookingCreateModel bookingCreateModel = BookingCreateModel(
        offerTitle: "offerTitle",
        offerDescription: "offerDescription",

        category: chatController.request.value?.category ?? 'category null',
        subCategories:  chatController.request.value?.subCategories ?? [],
        business: '',
        request: chatController.request.value?.requestId ??''
    );

      final bool isSuccess =
          await bookingConfirmRepository.bookingCreate(bookingCreateModel);
      bookingConfirmRepository.inProgress == true;

      if (isSuccess) {
        bookingConfirmRepository.inProgress == false;

        AppSnackBar.success(
            bookingConfirmRepository.successfullyMessage ?? 'Successful!');
        appLog(
            'success message => ${bookingConfirmRepository.successfullyMessage}');

        Get.toNamed(AppRoutes.userBookingSuccessfullScreen,);

      } else {
        bookingConfirmRepository.inProgress == false;
        // error message
        AppSnackBar.message('${bookingConfirmRepository.errorMessage}');
        appLog('error message => ${bookingConfirmRepository.errorMessage}');
      }


  }
}
