
import 'dart:async';
import 'dart:convert';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';


import '../../../constants/api_urls.dart';
import '../../../models/chat_message_responce_model.dart';
import '../../../models/faq_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/request_list_model.dart';
import '../../../models/terms_and_conditions_model.dart';
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






 /* class RequestListController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  List<Request> _originalRequestList = [];
  List<Request> _filteredRequestList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Request> get requestList => _filteredRequestList;

  Future<bool> fetchRequestList() async {
  _isLoading = true;
  update();

  final response = await ApiService.getApi(
  ApiUrls.chatListUrl,
  header: {
  'Authorization': 'Bearer ${LocalStorage.token}',
  },
  );

  bool isSuccess = false;

  if (response.statusCode == 200) {
  try {
  final List dataList = response.body['data']['data'];
  _originalRequestList =
  dataList.map((item) => Request.fromJson(item)).toList();
  _filteredRequestList = _originalRequestList;
  _errorMessage = null;
  isSuccess = true;

  if (_originalRequestList.isNotEmpty) {
  Get.find<ChatController>().setId(_originalRequestList[0].id);
  }
  } catch (e) {
  _errorMessage = "Data parsing error";
  }
  } else {
  _errorMessage = response.message;
  }

  _isLoading = false;
  update();
  return isSuccess;
  }

  void filterList(String query) {
  if (query.isEmpty) {
  _filteredRequestList = _originalRequestList;
  } else {
  _filteredRequestList = _originalRequestList.where((request) {
  return request.message.toLowerCase().contains(query.toLowerCase());
  }).toList();
  }
  update();
  }

  Future<void> refreshRequestList() async {
  _originalRequestList = [];
  await fetchRequestList();
  update();
  }
  }


*/






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



  Future<List<ChatMessageResponseModel>> getChatMessage({ required int page,  required String chatId})async{
    List<ChatMessageResponseModel> chatMessageResponseModelList = <ChatMessageResponseModel>[];
    try{
      Map<String, dynamic> queryParameters = {"page": page,"limit":20};
      appLog('current page😒😒 ====>>> $page');
      appLog('chat ID😒😪😒 ====>>> $chatId');

      var response = await  apiServices.apiGetServices("${ApiUrls.baseUrl}/message/$chatId", queryParameters:queryParameters );
      if(response != null){
        if(response["data"] != null && response["data"] is Map){
          var data = response["data"];
          if(data["data"] != null && data["data"] is List){
            for(var item in data["data"]){
              chatMessageResponseModelList.add(ChatMessageResponseModel.fromJson(item));
            }
          }

        }
      }

    }catch(e){

      errorLog('getChatMessage======>>>  $e');
    }
    return chatMessageResponseModelList;
  }

  ///
  Future<ChatMessageResponseModel?> sendMessage(
      {required String message,
        required String chatId,
        required List<XFile> imageUrl}) async{

    FormData formData = FormData.fromMap({
      "data": '''{
        "message": "$message"
      }''',
    });
    if(imageUrl.isNotEmpty){
      for(var i in imageUrl){
        var mimeType = lookupMimeType(i.path);
        formData.files.add(MapEntry("image", await MultipartFile.fromFile(i.path, filename: i.path.split("/").last, contentType: MediaType.parse(mimeType ?? "application/octet-stream"))));
      }
    }

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



  Future<ChatMessageResponseModel?> sendOffer(
      {required String offerTitle,
        required String offerDescription,
        required String chatId,
       }) async{

    FormData formData = FormData.fromMap({
      "data": ''' {
  "offerTitle": "$offerTitle",
  "offerDescription": "$offerDescription"
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
