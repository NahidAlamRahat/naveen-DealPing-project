
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../utils/app_log/error_log.dart';

class UserChatController extends GetxController {
  AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> images = [];

  String chatId = '';

  // bool isAtBottom = true;

  setChatId(String? chatId) {
    if (chatId == null) {
      appLog('chat id null===');
      return;
    }
    this.chatId = chatId;
    onAppInitialDataLoad();
    appLog("==cha id main?===>>$chatId");

  }

  CommonRepository commonRepository = CommonRepository();

  RxList<ChatMessageResponseModel> chatMessages =
      <ChatMessageResponseModel>[].obs;

  int currentPage = 1;
  RxBool isLoading = false.obs;
  RxBool isPagination = false.obs;
  bool isLast = false;

  Future<void> fetchChatMessages() async {
    try {
   if(isLast){
     isLoading.value = false;
     isPagination.value = false;
     return;
   }

      final data = await commonRepository.getChatMessage(page: currentPage, chatId: chatId);

      if (data.isNotEmpty) {
        chatMessages.addAll(data);
        chatMessages.refresh();
      }else {
        isLast = true;
      }
   currentPage++;
    } catch (e) {
      errorLog(' fetchChatMessages errorLog=====>$e');
    }
    isLoading.value = false;
    isPagination.value = false;

  }
bool isMessageSent = false;

  Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      if(isMessageSent) return;
      isMessageSent = true;

      var response = await commonRepository.sendMessage(
        message: messageController.text.trim(),
        chatId: chatId,
        imageUrl: images,
      );

      if (response != null) {

        messageController.clear();
        images.clear();
        // scrollToBottom();
      }
    }  catch (e) {
      errorLog(' sendMessage errorLog=====>$e');
    }
    isMessageSent = false;
  }


  // Pick images for the message
  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    images.addAll(pickedImages);
    update();
  }


  void scrollToBottom() {
    try {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
    catch (e) {
      errorLog(" scrollToBottom========>>>  $e");
    }
  }

  // void scroll(){
  //    try {
  //      scrollController.addListener(() {
  //        if (scrollController.position.pixels <= 100 && !isLoading.value) {
  //          // fetchCha
  //          tMessages();
  //        }
  //        if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
  //          isAtBottom = true;
  //        }else{
  //          isAtBottom = false;
  //        }
  //      });
  //    } catch (e) {
  //    AppSnackBar.error('Something went wrong\n$e');
  //    }
  //  }

  void chatMessageSocketHandler(dynamic message) {
    try {

      chatMessages.insert(
         0, ChatMessageResponseModel.fromJson(message));
      // chatMessages.add(ChatMessageResponseModel.fromJson(message));
      chatMessages.refresh();
      appLog('rahat');
    } catch (e) {
      errorLog("chatMessageSocketHandler $e");
    }
  }

  void paginationData(){
    try{
      scrollController.addListener((){
        appLog(scrollController.position.pixels);
        isPagination.value = true;
        fetchChatMessages();
      });
    }catch(e){
      errorLog(e);
    }
  }

  Future<void> onAppInitialDataLoad() async {
    try {
      scrollController = ScrollController();
      messageController = TextEditingController();
      chatMessages.clear();
      currentPage = 1;

       isLoading.value = true;
       isPagination.value = false;

      await fetchChatMessages();


      appSocketAllOperation.readEvent(
          event: "message::$chatId",
          handler: (data) {

            chatMessageSocketHandler(data);


          });
      paginationData();
    } catch (e) {
      errorLog(' appSocketAllOperation errorLog=====>$e');

      appLog('😎😎😎😪😪😪😪😪😪😪😎  $e');
    }
  }





  void onAppClose() {
    try {
      messageController.dispose();
      scrollController.dispose();
    } catch (e) {
      errorLog(' onAppClose errorLog=====>$e');
    }
  }

  @override
  void onInit() {

    appLog(' onInit call=====>done');

    onAppInitialDataLoad();

    super.onInit();
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
