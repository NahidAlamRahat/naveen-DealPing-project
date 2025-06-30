import 'package:deal_ping/services/repository/auth_repository/common_repository_controller/verify_otp_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/sign_in_api_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/sign_up_api_controller.dart';
import 'package:get/get.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(UserSignUpApiController());
    Get.put(SignInApiController());
    Get.put(VerifyOtpController());
  }
}
