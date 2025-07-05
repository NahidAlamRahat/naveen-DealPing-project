/*
String _getDomain() {
  String serverDomain =
      "https://asad.binarybards.online"; //////////// live server
  String localDomain = "http://10.0.80.49:5010"; ///////// local server
  try {
    if (kReleaseMode) {
      return serverDomain;
    } else {
      return localDomain;
    }
  } catch (e) {
    errorLog("_getDomain", e);
    return serverDomain;
  }
}
*/

class ApiUrls {
  ApiUrls._();

  // base url
  // static final String domain = _getDomain();
  static const String baseUrl = "https://asad.binarybards.online/api/v1";
  static const String imageUrl = "https://asad.binarybards.online";

  // auth urls
  static String login = "$baseUrl/auth/login";
  static const String createUserAccount = "$baseUrl/user/create-user";
  static const String verifyEmail = "$baseUrl/auth/verify-account/";
  static const String resendOtp = "$baseUrl/auth/resend-otp";
  static const String refreshToken = "$baseUrl/auth/refresh-token";
  static const String forgotPassword = "$baseUrl/auth/forget-password";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "/auth/change-password";
  static const String profile = "/user/profile";
  static const String updateProfile = "/user/profile";

  // category urls
  static const String categories = "/category/";
  static const String createOffer = "/offer/";
  static const String getAllOffer = "/offer/";
  static const String updateOffer = "/offer/";
  static const String deleteOffer = "/offer/";

  // Common urls
  static const String faq = "/public/faq/all";
  static const String termsAndCondition = "/public/terms-and-condition";
  static const String createRequest = "$baseUrl/request/create-request";
  static const String chatListUrl = "$baseUrl/request";
}
