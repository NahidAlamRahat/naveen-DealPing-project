import 'package:deal_ping/models/request_list_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../constants/api_urls.dart';
import '../../../models/user_chat_list_model.dart';

class ChatController extends GetxController {
  Rxn<Request> request = Rxn<Request>();
  final ApiUrls _apiUrls = ApiUrls();
  var chatList = <ChatModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  String id = '';  // To store dynamic id

  // Setter method to update id dynamically
  void setId(String newId) {
    debugPrint('😎😎😎😎😎=====>>>$newId');

    id = newId;

    debugPrint('chat id😎😎😎😎😎=====>>>${chatList[0].chatId}');

    fetchChatData(id: id); // Re-fetch data when ID changes
  }

  // Fetch chat data from the API using the updated id
  Future<void> fetchChatData({required id}) async {
    try {
      isLoading.value = true;
      update(); // Manually trigger UI update when loading starts

      var response = await ApiService.getApi(ApiUrls.userChatUrl(requestId: id));
      debugPrint('fetchChatData()  id : ${ApiUrls.userChatUrl(requestId: id)}');

      if (response.statusCode == 200) {
        List<ChatModel> chats = (response.body['data'] as List)
            .map((item) => ChatModel.fromJson(item))
            .toList();

        chatList.assignAll(chats); // Update the observable list with fetched chats
        errorMessage.value = ''; // Clear previous error message
      } else {
        errorMessage.value = 'Failed to load chats';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      update(); // Trigger UI update after data is fetched
    }
  }


  Future<void> appOnInit() async {
    try {
      isLoading.value = true;
      final argData = Get.arguments;
      if(argData != null && argData is Request){
        request.value = argData;
        id = request.value?.id ?? "";
        debugPrint('😎😎😎😎😎=====>>>${request.value?.message}');
          await fetchChatData(id: id);
      }
      // await fetchChatData();
    } catch (e) {
      debugPrint('error from ${e.toString()}');
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    appOnInit();
    super.onInit();
  }


  // Refresh the chat data when needed
  Future<void> refreshChats() async {
    chatList.clear();
    await fetchChatData(id: id);
  }
}
