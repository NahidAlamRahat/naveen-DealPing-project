import 'package:deal_ping/models/user_chat_list_model.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/error_log.dart';

class UserChatController extends GetxController {
  AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  RxInt selectedChatIndex = 0.obs;


  final ImagePicker _picker = ImagePicker();
  final RxList<XFile> images = <XFile>[].obs;
  bool isMessageSent = false;
  CommonRepository commonRepository = CommonRepository();



  String requestId = '';
  String chatId = '';


  RxList<ChatMessageResponseModel> chatMessagesList =
      <ChatMessageResponseModel>[].obs;

  int currentPage = 1;
  RxBool isLoading = false.obs;
  RxBool isPagination = false.obs;
  bool isLast = false;



  RxBool hasUserReplied = false.obs;

  void checkIfUserReplied() {
    try {
      bool anyUserMessage = chatMessagesList.any(
            (msg) => msg.sender?.id != LocalStorage.userId,
      );
      hasUserReplied.value = anyUserMessage;
    } catch (e) {
      errorLog("checkIfUserReplied error: $e");
    }
  }



  Future<void> fetchChatMessages() async {
    try {
      if(isLast){
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

      final data = await commonRepository.getChatMessage(
          page: currentPage, chatId: chatId, requestId: requestId);

      if (data.isNotEmpty) {
        chatMessagesList.addAll(data);
        chatMessagesList.refresh();
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


  Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      if(isMessageSent) return;
      isMessageSent = true;
      update();


      var response = await commonRepository.sendMessage(
          message: messageController.text.trim(),
          requestId: requestId,
          imageUrl: images,
          chatId: chatId
      );



      if (response != null) {
        messageController.clear();
        images.value=[];
        images.refresh();
        update();
      }

    }  catch (e) {
      errorLog(' sendMessage errorLog=====>$e');
    }
    isMessageSent = false;
    update();
  }


  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      images.clear();
      images.addAll(pickedImages);
      images.refresh();
      update();
    }
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

  void chatMessageSocketHandler(dynamic message) {
    try {

      chatMessagesList.insert(
        0, ChatMessageResponseModel.fromJson(message['data']));
      // chatMessagesList.add(ChatMessageResponseModel.fromJson(message));
      chatMessagesList.refresh();
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
      isLoading.value = true;
      isPagination.value = false;

      final argData = Get.arguments;

      if (argData != null && argData is Map) {
        final ChatModel chat = argData['chat'] as ChatModel;
        final String requestId = argData['requestId'].toString();

        appLog('request id👌👌→→→===>> $requestId');
        appLog('chat data😥😥😥 ===>> ${chat.chatId}');

        chatId = chat.chatId;
        this.requestId = requestId;

        scrollController = ScrollController();
        messageController = TextEditingController();

        chatMessagesList.clear();
        currentPage = 1;
        await fetchChatMessages();

        appLog("==========================chat Socket  ============================");


        appSocketAllOperation.readEvent(
          event: "message::$chatId",
          handler: (data) {
            chatMessageSocketHandler(data);
            appLog('👌👌👌👌new chat==>>> ${data}  ');

          },
        );
        await fetchChatMessages();



        paginationData();
      }
      else{
        appLog("chat id not found");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // Get.offAndToNamed(AppRoutes.n)
        },);
      }

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
    images.clear();
    onAppClose();
    super.onClose();
  }
}
