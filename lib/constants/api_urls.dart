import 'package:flutter/foundation.dart';

import '../utils/app_all_log/error_log.dart';

String _getDomain() {
  String serverDomain =
      "https://www.api.914unplugged.com"; //////////// live server
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

class ApiUrls {
  ApiUrls._();

  // base url
  static final String domain = _getDomain();
  static final String baseUrl = "$domain/api/v1";

  // auth urls
  static const String createUserAccount = "/user/create-user";
  static const String verifyEmail = "/auth/verify-account/";
  static const String resendOtp = "/auth/resend-otp";
  static const String login = "/auth/login";
  static const String refreshToken = "/auth/refresh-token";
  static const String forgotPassword = "/auth/forget-password";
  static const String resetPassword = "/auth/reset-password";
  static const String profile = "/user/influencer-profile";
  static const String profileUpdate = "/user";
  static const String privacyPolicy = "/rule/privacy-policy";
  static const String termsCondition = "/rule/terms-and-conditions";
  static const String faq = "/faq";
  static const String campaignList = "/campaign/influencer";
  static const String changePassword = "/auth/change-password";
  static const String deleteAccount = "/auth/delete-account";
  static const String chatList = "/chat/influencer-chat";
  static const String makeApplication = "/application";
  static const String getApplication = "/application/influencer";
  static const String notification = "/notification";
  static const String readNotification = "/notification";
  static const String sendMessage = "/message";
  static const String bankDetails = "/bank";
  static const String addBank = "/bank";
  static const String provedSubmit = "/proved";
}
