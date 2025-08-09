import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_log/app_log.dart';

class BookingConfirmRepository extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;
  String? get successfullyMessage => _successfullyMessage;

  /// এখন এই মেথড Future<Map<String, dynamic>?> রিটার্ন করবে
  Future<Map?> bookingCreate(var bookingCreateModel) async {
    _inProgress = true;
    update();

    try {
      var response = await ApiService.postApi(
        ApiUrls.bookingCreateUrl,
        bookingCreateModel,
      );

      if (response.statusCode == 200) {
        _successfullyMessage = response.message;
        // _errorMessage = null;
        await Get.toNamed(AppRoutes.userBookingSuccessfullScreen,
            arguments: response.body['data']['code']);
        
        _inProgress = false;
        update();

        // response.data ধরে নিচ্ছি Map<String, dynamic>
        return response.body;  // এখানে পুরো ডেটা রিটার্ন করলাম
      } else {
        _errorMessage = response.message;
        _successfullyMessage = null;

        _inProgress = false;
        update();

        return null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _successfullyMessage = null;
      _inProgress = false;
      update();

      return null;
    }
  }
}
