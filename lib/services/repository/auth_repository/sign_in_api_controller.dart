import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';

import '../../storage/storage_key.dart';
import '../../storage/storage_service.dart';

class SignInApiController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

  Future<bool> signInApiCall({required signInModel}) async {
    _inProgress = true;
    _errorMessage = null;
    _successfullyMessage = null;
    update();

    final response = await ApiService.postApi(
      ApiUrls.login,
      signInModel,
    );

    _inProgress = false;

    if (response.statusCode == 200) {
      String accessToken = response.body['data']?['accessToken'] ?? "";
      String refreshToken = response.body['data']?['refreshToken'] ?? "";
      String role = response.body['data']?['role'] ?? "";

      LocalStorage.token = accessToken;

      LocalStorage.refreshToken = refreshToken;
      LocalStorage.myRole = role;

      LocalStorage.setString(
        LocalStorageKeys.token,
        LocalStorage.token,
      );
      LocalStorage.setString(
          LocalStorageKeys.refreshToken, LocalStorage.refreshToken);
      LocalStorage.setString(LocalStorageKeys.myRole, LocalStorage.myRole);

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
