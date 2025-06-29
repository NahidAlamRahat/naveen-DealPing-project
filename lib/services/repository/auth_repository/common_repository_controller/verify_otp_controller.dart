import 'package:deal_ping/models/verify_otp_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  Future<bool> verifyOtp(
      {required VerifyOtpModel verifyOtpModel, required url}) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    final response = await ApiService.postApi(
      url,
      verifyOtpModel,
    );
    print("response $response");
    print('url => $url');

    _inProgress = false;

    if (response.statusCode == 200) {
      print('message => ${response.message}');
      _successfullyMessage = response.message;
      update();
      print("response ${response.statusCode}");
      return true;
    } else {
      print('Error message => ${response.message}');
      _errorMessage = response.message;
      update();
      return false;
    }
  }
}
