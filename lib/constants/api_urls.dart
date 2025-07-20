
import 'package:deal_ping/screens/user_screens/user_bookings_screen/controller/booking_list_api_caller.dart';
import 'package:flutter/foundation.dart';

import '../utils/app_log/error_log.dart';

String _getDomain() {
  String serverDomain =
      "https://divx-rare-realtor-immune.trycloudflare.com"; //////////// live server
  String localDomain = "https://divx-rare-realtor-immune.trycloudflare.com"; ///////// local server
  try {
    if (kReleaseMode) {
      return serverDomain;
    } else {
      return localDomain;
    }
  } catch (e) {
    errorLog("_getDomain",);
    return serverDomain;
  }
}


class ApiUrls {
  // instance variable
  String id;


  // constructor
  ApiUrls({this.id = ''});

  // base url
  static final String domain = _getDomain();
  // static const String baseUrl = "https://perceived-bare-wholesale-lives.trycloudflare.com/api/v1";
  static const String baseUrl = "http://10.10.7.26:5000/api/v1";

  static const String imageUrl = "http://10.10.7.26:5000";

  // auth urls
  static String login = "$baseUrl/auth/login";
  static const String createUserAccount = "$baseUrl/user/create-user";
  static const String verifyEmail = "$baseUrl/auth/verify-account/";
  static const String resendOtp = "$baseUrl/auth/resend-otp";
  static const String refreshToken = "$baseUrl/auth/refresh-token";
  static const String forgotPassword = "$baseUrl/auth/forget-password";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String profile = "/user/profile";
  static const String updateProfile = "/user/profile";

  // category urls
  static const String categories = "$baseUrl/category/";
  static const String subCategories = "$baseUrl/subcategory/";
  static const String createOffer = "$baseUrl/offer/";
  static const String getAllOffer = "$baseUrl/offer/";
  static const String updateOffer = "$baseUrl/offer/";
  static const String deleteOffer = "$baseUrl/offer/";

  // Common urls
  static const String faq = "/public/faq/all";
  static const String termsAndCondition = "/public/terms-and-condition";
  static const String about = "/public/about-us";

  static const String createRequest = "$baseUrl/request/create-request";
  static const String chatListUrl = "$baseUrl/request";

  static  String bookingListUrl({required double longitude, required double latitude, required BookingStatus status })
                        => "$baseUrl/booking/?longitude=$longitude&latitude=$latitude&status=${status.name}";

 static String  userChatUrl({required String id}) => "$baseUrl/chat/user/$id";

  static const String userNotificationsUrl = "$baseUrl/notifications";

  static String businessChatListUrl({required String status}) => "$baseUrl/chat/businesses?status=$status";







}
