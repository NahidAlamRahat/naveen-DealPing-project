import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserBookingSummaryController extends GetxController {
  // User Details
  final RxString name = "John Doe".obs;
  final RxString email = "johndoe67@gmail.com".obs;
  final RxString phone = "+7208974308485".obs;
  final RxString location = "Buffalo, The USA".obs;
  final RxString barType = "Dance Bar".obs;

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

  // Confirm Booking
  void confirmBooking() {
    // Here you would typically add booking logic
    // For now, we'll just print the booking details
    print('Booking Confirmed:');
    print('Date: ${DateFormat('dd MMM yyyy').format(selectedDate.value)}');
    print('Time: ${selectedTime.value.format(Get.context!)}');
    print('People: ${numberOfPeople.value}');
  }
}
