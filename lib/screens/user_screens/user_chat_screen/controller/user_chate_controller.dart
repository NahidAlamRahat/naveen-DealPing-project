import 'package:deal_ping/utils/app_log/app_log.dart';
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
  final RxList<XFile> images = <XFile>[].obs;
  bool isMessageSent = false;
  CommonRepository commonRepository = CommonRepository();



  String chatId = '';

  // bool isAtBottom = true;

  /*setChatId(String? chatId) {
    if (chatId == null) {
      appLog('chat id null===');
      return;
    }
    this.chatId = chatId;
    onAppInitialDataLoad();
    appLog("==cha id main?===>>$chatId");

  }*/




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




 /* Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      if(isMessageSent) return;
      isMessageSent = true;
      update();

      var response = await commonRepository.sendMessage(
        message: messageController.text.trim(),
        chatId: chatId,
        imageUrl: images,
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
  }*/





  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty && images.isEmpty) return;
    if (isMessageSent) return;

    isMessageSent = true;
    update();

    appLog("Before sending => ${images.length} images: $images");

    try {
      var response = await commonRepository.sendMessage(
        message: messageController.text.trim(),
        chatId: chatId,
        imageUrl: images,
      );

      if (response != null) {
        messageController.clear();
        images.value = [];
        images.refresh();
        update(); // ✅ Ensure UI clears
      }
    } catch (e) {
      errorLog('sendMessage errorLog=====>$e');
    } finally {
      isMessageSent = false;
      update();
    }
  }




  // Pick images for the message
  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      images.addAll(pickedImages);
      update(); // Ensure this if using GetBuilder
    }    print('pickImage😊😊😊😊👌👌 path ==>> ${pickedImages.first.path}');
    appLog('pickImage😊😊😊😊👌👌image $images\npickedImages ==>> $pickedImages');
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
      isLoading.value = true;
      isPagination.value = false;

      final argData  = Get.arguments;
if(argData != null && argData is String){
  chatId = argData;
  scrollController = ScrollController();
  messageController = TextEditingController();
  chatMessages.clear();
  currentPage = 1;
  await fetchChatMessages();


  appSocketAllOperation.readEvent(
      event: "message::$chatId",
      handler: (data) {

        chatMessageSocketHandler(data);


      });
  paginationData();
}else{
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
