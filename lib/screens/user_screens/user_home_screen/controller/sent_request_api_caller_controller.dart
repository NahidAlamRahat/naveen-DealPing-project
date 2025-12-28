import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/models/sent_home_screen_data_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

import '../../../../utils/app_log/app_log.dart';

class SentRequestController extends GetxController {
  final _inProgress = false.obs;
  bool get inProgress => _inProgress.value;
  set inProgress(bool value) => _inProgress.value = value;

  final _errorMessage = RxnString();
  String? get errorMessage => _errorMessage.value;

  final _successfullyMessage = RxnString();
  String? get successfullyMessage => _successfullyMessage.value;

  Future<bool> createRequest(RequestModel requestModel) async {
    bool isSuccess = false;
    inProgress = true;

    var response = await ApiService.postApi(
      ///Url
      ApiUrls.createRequest,
      requestModel,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _successfullyMessage.value = response.message;
      appLog('response message => ${response.message}');

      inProgress = false;
      isSuccess = true;
    } else {
      _errorMessage.value = response.message;
      inProgress = false;
      isSuccess = false;
    }

    return isSuccess;
  }
}
