import 'package:deal_ping/models/verify_otp_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_log/app_log.dart';

class VerifyOtpController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  verifyOtp({required VerifyOtpModel verifyOtpModel, required url}) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    var response = await ApiService.postApi(
      url,
      verifyOtpModel,
    );
    debugPrint("response == $response");
    debugPrint('url => $url');

    _inProgress = false;

    if (response.statusCode == 200) {
      appLog('message => ${response.body}');

      _successfullyMessage = response.message;
      appLog('Success message ===> ${response.message} <===');
      _successfullyMessage = response.message;
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('SuccessMessage ==> $successfullyMessage <==');

      update();
      appLog("response ${response.statusCode}");
      return response.body;
    } else {
      appLog('Error message ===> ${response.message} <===');
      _errorMessage = response.message;
      debugPrint('_errorMessage ==> $_errorMessage');
      debugPrint('ErrorMessage ==> $errorMessage <==');

      update();
      return false;
    }
  }
}
