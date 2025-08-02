import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/change_password_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

import '../../../../utils/app_log/app_log.dart';


class UserChangePasswordApiCaller extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  changePasswordApiCaller({
    required ChangePasswordModel changePasswordModel,
    required var resetToken,
  }) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    try {
      final response = await ApiService.postApi(
        ApiUrls.changePassword,
        changePasswordModel,
        header: resetToken,
      );

      _inProgress = false;

      if (response.statusCode == 200) {
        _successfullyMessage = response.message;
        appLog('Success message => $_successfullyMessage');
        update();
        return true;
      } else {
        _errorMessage = response.message;
        appLog('Error message => $_errorMessage');
        update();
        return false;
      }
    } catch (e) {
      _inProgress = false;
      _errorMessage = "Something went wrong: $e";
      appLog('Exception => $e');
      update();
      return false;
    }
  }
}