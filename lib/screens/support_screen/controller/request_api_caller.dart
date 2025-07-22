import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_log/app_log.dart';

/*
class RequestApiController extends GetxController {
  RxBool _inProgress = false.obs;

  bool get inProgress => _inProgress.value;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  sentRequest(var requestModel) async {
    bool isSuccess = false;
    _inProgress = true.obs;
    update();

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.supportUrl,
      requestModel,
    );
    if (response.statusCode == 200) {
      _successfullyMessage = response.message;

      appLog('response message => ${response.message}');

      _successfullyMessage = response.message;

      appLog(
          'Success message *==> ${_successfullyMessage = response.message} <===*');
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('SrrorMessage ==> $successfullyMessage <==');

      _inProgress = false.obs;
      _errorMessage = null;
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
*/


class RequestApiController extends GetxController {
  final RxBool _inProgress = false.obs;

  bool get inProgress => _inProgress.value;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;
  String? get successfullyMessage => _successfullyMessage;

  Future<bool> sentRequest(var requestModel) async {
    bool isSuccess = false;
    _inProgress.value = true;
    update();

    var response = await ApiService.postApi(
      ApiUrls.supportUrl,
      requestModel,
    );

    if (response.statusCode == 200) {
      _successfullyMessage = response.message;

      appLog('response message => ${response.message}');
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('ErrorMessage ==> $successfullyMessage <==');

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.message;
    }

    _inProgress.value = false;
    update();

    return isSuccess;
  }
}
