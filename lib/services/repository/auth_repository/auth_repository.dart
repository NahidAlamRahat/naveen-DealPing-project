import 'package:deal_ping/constants/api_urls.dart';

import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_post_services.dart';
import '../../storage_services/app_auth_storage.dart';

class AuthRepository {
  ////////////  object
  ApiPostServices apiPostServices = ApiPostServices();
  AppAuthStorage appAuthStorage = AppAuthStorage();

  // Future<bool> signIn({
  //   required String email,
  //   required String password,
  //   required bool remember,
  // }) async {
  //   try {
  //     var response = await apiPostServices.apiPostServices(
  //         url: ApiUrls.signIn, body: {"email": email, "password": password});
  //     if (response != null) {
  //       if (response["data"]["accessToken"].runtimeType != Null &&
  //           response["data"]["refreshToken"].runtimeType != Null) {
  //         await appAuthStorage
  //             .setToken(response["data"]["accessToken"].toString());
  //         if (remember) {
  //           await appAuthStorage
  //               .setRefreshToken(response["data"]["refreshToken"].toString());
  //         }
  //         return true;
  //       }
  //     }
  //     return false;
  //   } catch (e) {
  //     errorLog("sign in repo  function ", e);
  //     return false;
  //   }
  // }

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

  Future<bool> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      var response = await apiPostServices.apiPostServices(
        url: ApiUrls.createUserAccount,
        body: {
          "name": firstName,
          //"lastName": lastName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "role": "user",
        },
      );
      if (response != null) {
        if (response["message"].runtimeType != Null) {
          AppSnackBar.message(response["message"].toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog("sign up repo provider  function ", e);
      return false;
    }
  }

  Future<bool> verifySignup({
    required String email,
    required String otp,
  }) async {
    try {
      var response = await apiPostServices.apiPostServices(
        url: ApiUrls.verifyEmail,
        body: {"email": email, "oneTimeCode": otp}, // Send OTP as a string
      );
      if (response != null) {
        if (response["message"].runtimeType != Null) {
          AppSnackBar.message(response["message"].toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog("verify signup repo function", e);
      return false;
    }
  }

  Future<bool> resendOtp({required String email}) async {
    try {
      var response = await apiPostServices.apiPostServices(
        url: ApiUrls.resendOtp,
        body: {"email": email},
      );
      if (response != null) {
        if (response["message"].runtimeType != Null) {
          AppSnackBar.message(response["message"].toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog("resend otp repo function", e);
      return false;
    }
  }

  Future<String?> forgotVerifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      var response = await apiPostServices.apiPostServices(
          url: ApiUrls.verifyEmail,
          body: {"email": email, "oneTimeCode": int.parse(otp)});
      if (response != null) {
        if (response["data"].runtimeType != Null) {
          return response["data"].toString();
        }
      }
      return null;
    } catch (e) {
      errorLog("forgot verify email repo", e);
      return null;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      var response = await apiPostServices
          .apiPostServices(url: ApiUrls.forgotPassword, body: {"email": email});
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("forgot password repo", e);
      return false;
    }
  }

  Future<bool> resetPassword(
      {required String newPassword,
      required String confirmPassword,
      required String token}) async {
    try {
      var response = await apiPostServices.apiPostServices(
          url: ApiUrls.resetPassword,
          token: token,
          body: {
            "newPassword": newPassword,
            "confirmPassword": confirmPassword
          });
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("reset password repo", e);
      return false;
    }
  }

  Future<bool> changePassword(
      {required String newPassword,
      required String confirmPassword,
      required String currentPassword}) async {
    try {
      var response = await apiPostServices
          .apiPostServices(url: ApiUrls.changePassword, body: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      });
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorLog("change password password repo", e);
      return false;
    }
  }
}
