import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';
import '../../../utils/app_log/app_log.dart';
import '../../storage/storage_key.dart';
import '../../storage/storage_service.dart';

class GoogleLoginApiController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _successfullyMessage = '';
  String get successfullyMessage => _successfullyMessage;

  // Return status code instead of bool for better handling
  Future<int> googleLoginApiCall({
    required String appId,
    String? deviceToken,
  }) async {
    _inProgress = true;
    _errorMessage = '';
    _successfullyMessage = '';
    update(); // Update UI for GetBuilder

    try {
      final response = await ApiService.postApi(
        ApiUrls.googleLogin,
        {
          "appId": appId,
          "deviceToken": deviceToken ?? "",
        },
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

        _successfullyMessage = response.message ?? "Google login successful";

        appLog('Google login successful for role: $role');
        update(); // Update UI for GetBuilder
        return 200;
      }
      else if (response.statusCode == 407) {
        _errorMessage = response.message ?? "OTP verification required";
        appLog('OTP verification required');
        update(); // Update UI for GetBuilder
        return 407;
      }
      else {
        _errorMessage = response.message ?? "Google login failed";
        appLog('Google login failed - Status: ${response.statusCode}, Message: ${response.message}');
        update(); // Update UI for GetBuilder
        return response.statusCode;
      }
    } catch (e) {
      _inProgress = false;
      _errorMessage = "Network error occurred";
      appLog('Google Login API Error: $e');
      update(); // Update UI for GetBuilder
      return 500; // Internal error
    }
  }
}
