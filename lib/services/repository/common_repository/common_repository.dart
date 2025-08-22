
import 'dart:async';
import 'package:deal_ping/models/support_history_model.dart';
import 'package:deal_ping/models/user-growth.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../../constants/api_urls.dart';
import '../../../models/booking_list_model.dart';
import '../../../models/chat_message_responce_model.dart';
import '../../../models/faq_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/request_list_model.dart';
import '../../../models/terms_and_conditions_model.dart';
import '../../../models/booking-growth.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_services.dart';
import '../../api/app_api_services.dart';

class CommonRepository {

  AppApiServices apiServices = AppApiServices.instance;

  Future<List<FAQData>?> fetchFAQs() async {
    try {
      var response = await ApiService.getApi(ApiUrls.faq);
      FAQ faqData = FAQ.fromJson(response.body);
      return faqData.data;
        } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while fetching FAQs.");
      return null;
    }
  }

  Future readNotification() async {
    try {
      var response = await ApiService.getApi(ApiUrls.readUserNotificationsUrl);
      if(response.statusCode ==200) AppSnackBar.message(response.message);

    } catch (e) {
      errorLog(e);
      AppSnackBar.error("An error occurred while fetching .");
    }
    return false;
  }


  Future<StaticPageModel?> fetchTermsAndConditions() async {
    try {
      final response = await ApiService.getApi(
        ApiUrls.termsAndCondition,
      );
      return StaticPageModel.fromJson(response.body);
        } catch (e) {
      // AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
      return null;
    }
  }


  Future<StaticPageModel?> fetchAboutUs() async {
    try {
      final response = await ApiService.getApi(
        ApiUrls.about,
      );
      return StaticPageModel.fromJson(response.body);
        } catch (e) {
      AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
      return null;
    }
  }







  Future<void> messageEnable({required String chatId}) async {
    try {
      final response = await ApiService.patchApi(
        ApiUrls.messageUrl(chatId: chatId),
      );

      if(response.statusCode==200){
        AppSnackBar.success(response.message);
      }

    } catch (e) {
      AppSnackBar.error("Error fetching terms and conditions: ${e.toString()}");
    }
  }


  Future<List<NotificationModel>> getNotificationData(int page) async {
    List<NotificationModel> notificationDataList = <NotificationModel>[];
    try {
      Map<String, dynamic> queryParameters = {"page": page};
      var response = await apiServices.apiGetServices("/notifications",
          queryParameters: queryParameters);
      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              notificationDataList.add(NotificationModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return notificationDataList;
  }

  Future<List<BookingModel>> getBookingList(
      {required int page, required  bookingStatus}) async {
    List<BookingModel> bookingModelDataList = <BookingModel>[];
    try {
      Map<String, dynamic> queryParameters = {"page": page};

      var response = await apiServices.apiGetServices(ApiUrls.bookingListUrl(
          longitude: 90.4125, latitude: 23.8103, status: bookingStatus),
          queryParameters: queryParameters);

      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              bookingModelDataList.add(BookingModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return bookingModelDataList;
  }





  Future<BookingStatsResponse?> bookingGrowth({
    required String status,
  }) async {
    try {
      var response = await apiServices.apiGetServices(
        ApiUrls.bookingGrowthUrl(status: status),
      );
      appLog('bookingGrowthUrl👌 ==>> $response');

      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          return BookingStatsResponse.fromJson(response["data"]);
        } else {
          appLog('Error: bookingGrowth data is not a Map');
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return null;
  }



  Future<UserGrowthResponse?> userGrowth({
    required String status,
  }) async {
    try {
      var response = await apiServices.apiGetServices(
        ApiUrls.userGrowthUrl(status: status),
      );
      appLog('user growth url ❤️ ==>> $response');

      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          return UserGrowthResponse.fromJson(response["data"]);
        } else {
          appLog('Error: bookingGrowth data is not a Map');
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return null;
  }




  Future<List<SupportHistoryModel>> getSupportHistoryData(int page) async {
    List<SupportHistoryModel> supportHistoryDataList = <SupportHistoryModel>[];
    try {
      Map<String, dynamic> queryParameters = {"page": page};
      var response = await apiServices.apiGetServices("/support/?status=pending",
          queryParameters: queryParameters);
      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              supportHistoryDataList.add(SupportHistoryModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return supportHistoryDataList;
  }


  Future<List<RequestModel>> getRequestList(int page) async {
    List<RequestModel> requestDataList = <RequestModel>[];
    try {
      Map<String, dynamic> queryParameters = {"page": page};
      var response = await apiServices.apiGetServices("/request",
          queryParameters: queryParameters);
      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              requestDataList.add(RequestModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog(e);
    }
    return requestDataList;
  }

  Future<List<ChatMessageResponseModel>> getChatMessage({
    required int page,
    required String chatId,
     String? requestId,

  }) async {
    List<ChatMessageResponseModel> chatMessageResponseModelList = [];

    try {
      Map<String, dynamic> queryParameters = {"page": page, "limit": 20};
      appLog('current page😒😒 ====>>> $page');
      appLog('chat ID😒😪😒 ====>>> $chatId');
      appLog('request ID8-)8-)8-)>.<>.< ====>>> $requestId');

      // ✅ ensure it's clean single ID, not list
      String cleanRequestId = requestId?.replaceAll(RegExp(r'[\[\]\s]'), '') ??'';

      String url =
          "${ApiUrls.baseUrl}/message/$chatId?requestId=$cleanRequestId";

      appLog("getChatMessage Url===>> $url");

      var response = await apiServices.apiGetServices(
        url,
        queryParameters: queryParameters,
      );

      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              chatMessageResponseModelList
                  .add(ChatMessageResponseModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog('getChatMessage======>>>  $e');
    }
    return chatMessageResponseModelList;
  }





  Future<List<ChatMessageResponseModel>> getBusinessChatMessage({
    required int page,
    required String chatId,
    required String status
  }) async {
    List<ChatMessageResponseModel> chatMessageResponseModelList = [];

    try {
      Map<String, dynamic> queryParameters = {"page": page, "limit": 20};
      appLog('current page😒😒 ====>>> $page');
      appLog('chat ID😒😪😒 ====>>> $chatId');
      appLog(''
          'status ID8-)8-)8-)>.<>.< ====>>> $status');

      String url =
          "${ApiUrls.baseUrl}/message/$chatId?status=$status";

      appLog("getChatMessage Url===>> $url");

      var response = await apiServices.apiGetServices(
        url,
        queryParameters: queryParameters,
      );

      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            for (var item in data["data"]) {
              chatMessageResponseModelList
                  .add(ChatMessageResponseModel.fromJson(item));
            }
          }
        }
      }
    } catch (e) {
      errorLog('getChatMessage======>>>  $e');
    }
    return chatMessageResponseModelList;
  }







  ///
  Future<ChatMessageResponseModel?> sendMessage({
    required String message,
    required String requestId,
    required String chatId,
    required List<XFile> imageUrl,
  }) async {
    // Clean requestId properly (remove [] and spaces if any)
    String cleanRequestId = requestId.replaceAll(RegExp(r'[\[\]\s]'), '');

    String cleanChatId = chatId.replaceAll(RegExp(r'[\[\]\s]'), '');


    FormData formData = FormData.fromMap({
      "data": '''{
      "message": "$message",
      "request": "$cleanRequestId"
    }''',
    });

    if (imageUrl.isNotEmpty) {
      for (var i in imageUrl) {
        var mimeType = lookupMimeType(i.path);
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              i.path,
              filename: i.path.split("/").last,
              contentType: MediaType.parse(mimeType ?? "application/octet-stream"),
            ),
          ),
        );
      }
    }

    appLog("------sendMessage id----------------- $requestId");
    appLog("------cleanRequestId----------------- $cleanRequestId");

    appLog("------cleanRequestId----------------- $cleanChatId");

    String url = '${ApiUrls.baseUrl}/message/$cleanChatId';
    appLog("------sendMessage url----------------- $url");

    var response = await ApiService.postApi(url, formData);

    appLog("------sendMessage response----------------- $response");
    appLog(response.body);

    if (response.statusCode == 200) {
      return ChatMessageResponseModel.fromJson(response.body['data']);
    } else {
      AppSnackBar.error(response.message);
      appLog(' sendMessage error message ==>>> ${response.message}');
      return null;
    }
  }





  Future<ChatMessageResponseModel?> sendOffer(
      {required String offerTitle,
        // required String offerDescription,
        required String chatId,
        required String requestId,
       }) async{

    FormData formData = FormData.fromMap({
      "data": ''' {
  "offerTitle": "$offerTitle",
    "request": "$requestId"

  }''',
    });

    var response =await  ApiService.postApi('${ApiUrls.baseUrl}/message/$chatId', formData);

    appLog("------sendMessage-----------------${ApiService.postApi('${ApiUrls.baseUrl}/message/$chatId', formData)}");
    appLog(response.body);
    if(response.statusCode == 200){
      return ChatMessageResponseModel.fromJson(response.body['data']);

    }else{
      AppSnackBar.error('sendMessage=====>> ${response.message}');
      return null;
    }
  }









}
