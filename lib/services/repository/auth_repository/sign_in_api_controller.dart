import 'package:deal_ping/constants/api_urls.dart';
import 'package:get/get.dart';

import '../../../models/sign_in_model.dart';
import '../../api/networkCallerHttp.dart';

class SignInController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  Future<bool> signIn(SignInModel signInModel) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      url: ApiUrls.login,
      body: signInModel.toJson(),
    );

    _inProgress = false;

    if (response.isSuccess) {
      _successfullyMessage = response.successfullyMessage;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
