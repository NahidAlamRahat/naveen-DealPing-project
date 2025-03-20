class ApiUrls {
  ApiUrls._();

  // base url
  static const String domain = "http://92.205.234.176:5000";
  static const String baseUrl = "$domain/api/v1";

  // auth urls
  static const String register = "/user";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendOtp = "/auth/resend-otp";
  static const String login = "/auth/login";
  static const String refreshToken = "/auth/refresh-token";
  static const String forgotPassword = "/auth/forgot-password";
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
