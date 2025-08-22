import 'package:deal_ping/models/booking_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserBarcodeController extends GetxController {
  // Booking Details
  BookingModel? bookingModel;

  // Date and Time
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 10, minute: 0).obs;

  // Barcode Details
  final RxString barcodeNumber = "DP-12345-67890".obs;

  // Format methods (Fix: Make them RxString)
  final RxString formattedDate = ''.obs;
  final RxString formattedTime = ''.obs;

  @override
  void onInit() {
    bookingModel = Get.arguments["booking"];
    super.onInit();
    updateFormattedDateTime();
  }

  void updateFormattedDateTime() {
    formattedDate.value = DateFormat('dd MMM, yyyy').format(selectedDate.value);
    formattedTime.value = selectedTime.value.format(Get.context!);
  }
}
