import 'package:e_commerce/core/services/network_caller.dart';
import 'package:e_commerce/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:e_commerce/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:e_commerce/features/common/controller/main_bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavBarController());
    Get.put(NetworkCaller());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());


  }

}