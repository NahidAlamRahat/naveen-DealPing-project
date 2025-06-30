import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/services/storage/storage_key.dart';
import 'package:deal_ping/services/storage/storage_service.dart';

import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class AuthRepository {
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.login,
        {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        String accessToken = response.body['data']?['accessToken'] ?? "";
        String refreshToken = response.body['data']?['refreshToken'] ?? "";

        LocalStorage.token = accessToken;
        LocalStorage.refreshToken = refreshToken;

        LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
        LocalStorage.setString(
            LocalStorageKeys.refreshToken, LocalStorage.refreshToken);
      }

      return false;
    } catch (e) {
      errorLog("login repo function");
      return false;
    }
  }

  // Future<bool> googleAndAppleLogin({
  //   required String userId,
  //   required String role,
  // }) async {
  //   try {
  //     var response = await apiPostServices.apiPostServices(
  //         url: ApiUrls.signIn,
  //         body: {"appId": userId, "role": role, "type": "social"});
  //     if (response != null) {
  //       if (response["data"]["accessToken"].runtimeType != Null &&
  //           response["data"]["refreshToken"].runtimeType != Null) {
  //         await appAuthStorage
  //             .setToken(response["data"]["accessToken"].toString());
  //
  //         await appAuthStorage
  //             .setRefreshToken(response["data"]["refreshToken"].toString());
  //
  //         return true;
  //       }
  //     }
  //     return false;
  //   } catch (e) {
  //     errorLog("sign in repo  function ", e);
  //     return false;
  //   }
  // }

  ///chanage korte hobe

  Future<bool> createBusiness({
    required String businessName,
    required String email,
    required String eiinNumber,
    required String licenseNumber,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.createUserAccount,
        {
          "businessName": businessName,
          "email": email,
          "eiin": eiinNumber,
          "license": licenseNumber,
          "password": password,
          "confirmPassword": confirmPassword,
          "role": "business",
        },
      );
      if (response != null) {
        if (response.message.runtimeType != Null) {
          AppSnackBar.message(response.message.toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog(e, source: "sign up repo provider  function ");
      return false;
    }
  }

/*
  Future<bool> verifySignup({

    required String email,
    required String otp,
  }) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.verifyEmail,
        {"email": email, "oneTimeCode": otp}, // Send OTP as a string
      );
      if (response != null) {
        if (response.message.runtimeType != Null) {
          AppSnackBar.message(response.message.toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog(e);
      return false;
    }
  }*/

  Future<bool> resendOtp({required String email}) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.resendOtp,
        {"email": email},
      );
      if (response.statusCode == 200) {
        if (response.message.runtimeType != Null) {
          AppSnackBar.message(response.message.toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog(
        "resend otp repo function",
      );
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      var response =
          await ApiService.postApi(ApiUrls.forgotPassword, {"email": email});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("forgot password repo");
      return false;
    }
  }

  // Future forgotVerifyEmail({
  //   required String email,
  //   required String otp,
  // }) async {
  //   try {
  //     var response = await ApiService.postApi(
  //       ApiUrls.verifyEmail,
  //       {"email": email, "oneTimeCode": otp}, // Send OTP as a string
  //     );
  //     if (response.statusCode == 200) {
  //       AppSnackBar.message(response.message.toString());
  //       return response.body; // Return the full response
  //     }
  //     return null; // Return null if the response is null
  //   } catch (e) {
  //     errorLog(e);
  //     return null; // Return null in case of an exception
  //   }
  // }

  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String resetToken,
  }) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.resetPassword,
        {
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
      if (response != null) {
        if (response.message != null) {
          AppSnackBar.message(response.message.toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog(e);
      return false;
    }
  }

  Future<bool> changePassword(
      {required String newPassword,
      required String confirmPassword,
      required String currentPassword}) async {
    try {
      var response = await ApiService.postApi(ApiUrls.changePassword, {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      });
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog(e);
      return false;
    }
  }

/* Future<bool> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      var response = await ApiService.postApi(
        ApiUrls.createUserAccount,
        {
          "name": firstName,
          //"lastName": lastName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "role": "user",
        },
      );
      if (response != null) {
        if (response.message.runtimeType != Null) {
          AppSnackBar.message(response.message.toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog(e);
      return false;
    }
  }*/
}
