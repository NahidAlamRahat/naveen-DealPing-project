import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_log/app_log.dart';

class BookingConfirmRepository extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  bookingCreate(var bookingCreateModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.bookingCreateUrl,
      bookingCreateModel,
    );
    if (response.statusCode == 200) {
      _successfullyMessage = response.message;

      appLog('response message => ${response.message}');

      _successfullyMessage = response.message;

      appLog(
          'Success message *==> ${_successfullyMessage = response.message} <===*');
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('SrrorMessage ==> $successfullyMessage <==');

      _inProgress = false;
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.message;
    }

    inProgress == false;
    update();

    return isSuccess;
  }
}
