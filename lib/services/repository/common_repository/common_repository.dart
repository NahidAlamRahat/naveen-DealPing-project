import 'package:deal_ping/models/chat_message_responce_model.dart';
import 'package:deal_ping/models/notification_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/services/api/app_api_services.dart';

import '../../../constants/api_urls.dart';
import '../../../models/faq_model.dart';
import '../../../models/terms_and_conditions_model.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

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


  Future<List<NotificationModel>> getNotificationData(int page)async{
    List<NotificationModel> notificationDataList = <NotificationModel>[];
    try{
      Map<String, dynamic> queryParameters = {"page": page};
   var response = await  apiServices.apiGetServices("/notifications", queryParameters:queryParameters );
if(response != null){
if(response["data"] != null && response["data"] is Map){
  var data = response["data"];
  if(data["data"] != null && data["data"] is List){
for(var item in data["data"]){
notificationDataList.add(NotificationModel.fromJson(item));
}
  }

}
}


    }catch(e){



      errorLog(e);
    }
    return notificationDataList;
  }



  Future<List<ChatMessageResponseModel>> getChatMessage(int page)async{
    List<ChatMessageResponseModel> chatMessageResponseModelList = <ChatMessageResponseModel>[];
    try{
      Map<String, dynamic> queryParameters = {"page": page};
      var response = await  apiServices.apiGetServices("/notifications", queryParameters:queryParameters );
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



      errorLog(e);
    }
    return chatMessageResponseModelList;
  }




}
