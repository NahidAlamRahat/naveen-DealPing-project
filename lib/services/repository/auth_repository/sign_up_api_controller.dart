import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';
import '../../../utils/app_log/app_log.dart';

class SignUpApiController extends GetxController {
  late bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  userSignUp(var signUpModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.createUserAccount,
      signUpModel,
    );
    if (response.statusCode == 200) {
      _successfullyMessage = response.message;

      appLog('response message => ${response.message}');

      _successfullyMessage = response.message;

      appLog(
          'Success message *==> ${_successfullyMessage = response.message} <===*');
      appLog('_successfullyMessage ==> $_successfullyMessage');
      appLog('errorMessage ==> $errorMessage <==');

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
