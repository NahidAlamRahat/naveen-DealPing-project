import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

import '../../../models/reset_password_model.dart';

class UserResetPasswordRepository extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  resetPasswordApiCaller(
      {required ResetPasswordModel resetPasswordModel,
      required String resetToken}) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    final response = await ApiService.postApi(
      ApiUrls.resetPassword,
      resetPasswordModel,
    );

    _inProgress = false;

    if (response.statusCode == 200) {
      print('message => ${response.message}');

      _successfullyMessage = response.message;
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
