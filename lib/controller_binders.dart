import 'package:deal_ping/screens/notification_screen/controller/notification_controller.dart';
import 'package:deal_ping/screens/user_screens/user_chat_screen/controller/user_chate_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/common_repository_controller/verify_otp_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/sign_in_api_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/google_login_api_controller.dart';
import 'package:deal_ping/services/repository/auth_repository/sign_up_api_controller.dart';
import 'package:get/get.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpApiController());
    Get.put(SignInApiController());
    Get.put(GoogleLoginApiController());
    Get.put(VerifyOtpController());

    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() =>  UserChatController(),);
  }
}
