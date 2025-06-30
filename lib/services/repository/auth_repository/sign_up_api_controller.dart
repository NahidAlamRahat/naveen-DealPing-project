import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

class UserSignUpApiController extends GetxController {
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

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.createUserAccount,
      userSignUpModel.toJson(),
    );
    if (response.statusCode == 200) {
      _successfullyMessage = response.message;
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
