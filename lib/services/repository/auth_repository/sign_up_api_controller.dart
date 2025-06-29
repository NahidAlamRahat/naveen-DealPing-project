import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:get/get.dart';

import '../../api/networkCallerHttp.dart';

class SignUpController extends GetxController {
  late bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  Future<bool> userSignUp(UserSignUpModel userSignUpModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      url: ApiUrls.createUserAccount,
      body: userSignUpModel.toJson(),
    );
    if (response.isSuccess) {
      _successfullyMessage = response.successfullyMessage;
      _signUpInProgress = false;
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }

    signUpInProgress == false;
    update();

    return isSuccess;
  }
}
