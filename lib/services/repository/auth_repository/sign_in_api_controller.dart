import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';
import '../../../utils/app_log/app_log.dart';
import '../../storage/storage_key.dart';
import '../../storage/storage_service.dart';

class SignInApiController extends GetxController {
  late bool _inProgress = false;

  // UserProfileController userProfileController = Get.put(UserProfileController());
  // BusinessProfileController businessProfileController = Get.put(BusinessProfileController());


  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;

  String? get successfullyMessage => _successfullyMessage;

/*
  Future<bool> signInApiCall({required signInModel , String? email}) async {
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

      // LocalStorage.userId =userProfileController. profile.value?.sId ?? '';


      LocalStorage.setString(
        LocalStorageKeys.token,
        LocalStorage.token,
      );
      LocalStorage.setString(
          LocalStorageKeys.refreshToken, LocalStorage.refreshToken);
      LocalStorage.setString(LocalStorageKeys.myRole, LocalStorage.myRole);

      _successfullyMessage = response.message;
      _inProgress = false;

      update();
      return true;
    }
    else if(response.statusCode == 407){
      Get.toNamed(
        AppRoutes.userSignupVerifyOtpScreen,
        arguments: {'email': email},

      );    }
    else {
      _inProgress = false;
      appLog('Error message => ${response.message}');
      _errorMessage = response.message;
      update();
      return false;
    }
  }
*/



  Future<bool> signInApiCall({required signInModel, String? email}) async {
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
      // ✅ Success case
      String accessToken = response.body['data']?['accessToken'] ?? "";
      String refreshToken = response.body['data']?['refreshToken'] ?? "";
      String role = response.body['data']?['role'] ?? "";

      LocalStorage.token = accessToken;
      LocalStorage.refreshToken = refreshToken;
      LocalStorage.myRole = role;

      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
      LocalStorage.setString(LocalStorageKeys.refreshToken, LocalStorage.refreshToken);
      LocalStorage.setString(LocalStorageKeys.myRole, LocalStorage.myRole);

      _successfullyMessage = response.message;
      update();
      return true;

    } else if (response.statusCode == 407) {
      // 🚀 Custom handling for 407
      appLog('Received 407 => Redirecting to special screen');
      Get.toNamed(
        AppRoutes.userSignupVerifyOtpScreen,
        arguments: {'email': email},);
      _errorMessage = response.message;
      _inProgress = false;
      update();
      return false;

    } else {
      // ❌ Error case
      _errorMessage = response.message;
      appLog('Error message => ${response.message}');
      update();
      return false;
    }
  }



}
