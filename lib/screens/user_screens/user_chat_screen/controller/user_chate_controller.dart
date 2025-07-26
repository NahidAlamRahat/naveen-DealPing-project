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

  Future<void> fetchChatMessages() async {
    try {
      isLoading.value = true;
      final data = await commonRepository.getChatMessage(currentPage);

      if (data.isNotEmpty) {
        chatMessages.addAll(data);
        currentPage++;
      }

      // if(isAtBottom){
      //   scrollToBottom();
      // }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorLog(e);
    }
  }

  Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      
      var response = await commonRepository.sendMessage(
        message: messageController.text.trim(),
        chatId: chatId,
        imageUrl: images,
      );
      
      if (response != null) {
        chatMessages.add(response);
        messageController.clear();
        images.clear();
        update();
      
        if (!scrollController.hasClients) return;
        scrollToBottom();
      }
    }  catch (e) {
      errorLog(e);
    }
  }

  // Pick images for the message
  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    images.addAll(pickedImages);
    update();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
          chatMessages.length - 1, ChatMessageResponseModel.fromJson(message));
      chatMessages.refresh();
    } catch (e) {
      errorLog("chatMessageSocketHandler $e");
    }
  }

  Future<void> onAppInitialDataLoad() async {
    try {
      scrollController = ScrollController();
      messageController = TextEditingController();
      await fetchChatMessages();
      // scroll();
      chatMessages.clear();
      currentPage = 1;



      appSocketAllOperation.readEvent(
          event: "message::$chatId",
          handler: (data) {
            chatMessageSocketHandler(data);
            appLog("😎😎😎😪😎 message::$chatId");
          });
    } catch (e) {
      appLog('😎😎😎😪😪😪😪😪😪😪😎  $e');
    }
  }

  void onAppClose() {
    try {
      messageController.dispose();
      scrollController.dispose();
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
