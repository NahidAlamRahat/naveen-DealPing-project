import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/change_password_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserChangePasswordApiCaller extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  changePasswordApiCaller(
      {required ChangePasswordModel changePasswordModel,  required var resetToken }) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    final response = await ApiService.postApi(
      ApiUrls.changePassword,
      ChangePasswordModel,
        header: resetToken,
    );

    _inProgress = false;

    if (response.statusCode == 200) {
      print('response message => ${response.message}');

      _successfullyMessage = response.message;

      print(
          'Success message *==> ${_successfullyMessage = response.message} <===*');
      debugPrint('_successfullyMessage ==> $_successfullyMessage');
      debugPrint('SrrorMessage ==> $successfullyMessage <==');

      update();
      return true;
    } else {
      print('Error message => ${response.message}');
      _errorMessage = response.message;
      update();
      return false;
    }
  }
}
