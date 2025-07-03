import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/sent_home_screen_data_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentRequestController extends GetxController {
  late bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  createRequest(RequestModel requestModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.createRequest,
      requestModel,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _successfullyMessage = response.message;

      print('response message => ${response.message}');

      _successfullyMessage = response.message;

      print(
          'Success message *==> ${_successfullyMessage = response.message} <===*');
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('SrrorMessage ==> $successfullyMessage <==');

      _signUpInProgress = false;
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.message;
    }

    signUpInProgress == false;
    update();

    return isSuccess;
  }
}
