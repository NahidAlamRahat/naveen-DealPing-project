/*
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

  RxList<ChatMessageResponseModel> chatMessagesList = <ChatMessageResponseModel>[].obs;

  int currentPage = 1;
  RxBool isLoading = false.obs;
  RxBool isPagination = false.obs;
  bool isLast = false;

  RxBool hasUserReplied = false.obs;

  // ✅ Socket connection status track করার জন্য
  RxBool isSocketConnected = false.obs;
  String? currentSocketEvent;

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
      if (isLast) {
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

      appLog('🔄 Fetching messages for page: $currentPage');

      final data = await commonRepository.getChatMessage(
          page: currentPage, chatId: chatId, requestId: requestId);

      if (data.isNotEmpty) {
        appLog('✅ Received ${data.length} messages');
        chatMessagesList.addAll(data);
        chatMessagesList.refresh();
        currentPage++;
      } else {
        appLog('📭 No more messages - reached end');
        isLast = true;
      }
    } catch (e) {
      errorLog('❌ fetchChatMessages errorLog=====>$e');
      Get.snackbar('Error', 'Failed to load messages');
    } finally {
      isLoading.value = false;
      isPagination.value = false;
    }
  }

  Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      if (isMessageSent) return;

      isMessageSent = true;
      appLog('📤 Sending message...');

      var response = await commonRepository.sendMessage(
          message: messageController.text.trim(),
          requestId: requestId,
          imageUrl: images,
          chatId: chatId);

      if (response != null) {
        appLog('✅ Message sent successfully');
        messageController.clear();
        images.clear();
        images.refresh();

        // ✅ Message send করার পর একটু অপেক্ষা করুন তারপর refresh করুন
        await Future.delayed(const Duration(milliseconds: 500));
        await refreshMessages();
      } else {
        appLog('❌ Failed to send message');
        Get.snackbar('Error', 'Failed to send message');
      }
    } catch (e) {
      errorLog('❌ sendMessage errorLog=====>$e');
      Get.snackbar('Error', 'Failed to send message');
    } finally {
      isMessageSent = false;
      update();
    }
  }

  // ✅ Messages refresh করার জন্য আলাদা method
  Future<void> refreshMessages() async {
    try {
      appLog('🔄 Refreshing messages...');
      currentPage = 1;
      isLast = false;
      chatMessagesList.clear();
      await fetchChatMessages();
    } catch (e) {
      errorLog('❌ refreshMessages errorLog=====>$e');
    }
  }

  Future<void> pickImage() async {
    try {
      final List<XFile> pickedImages = await _picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        images.clear(); // আগের images clear করুন
        images.addAll(pickedImages);
        images.refresh();
        update();
        appLog('📷 Selected ${pickedImages.length} images');
      }
    } catch (e) {
      errorLog('❌ pickImage errorLog=====>$e');
      Get.snackbar('Error', 'Failed to pick images');
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
    } catch (e) {
      errorLog("❌ scrollToBottom error: $e");
    }
  }

  void chatMessageSocketHandler(dynamic message) {
    try {
      appLog('🔔 New message received via socket: $message');

      // ✅ Message validation
      if (message == null) {
        appLog('❌ Received null message from socket');
        return;
      }

      final newMessage = ChatMessageResponseModel.fromJson(message);

      // ✅ Duplicate message check
      bool isDuplicate = chatMessagesList.any((existingMsg) =>
      existingMsg.id == newMessage.id ||
          (existingMsg.message == newMessage.message &&
              existingMsg.createdAt == newMessage.createdAt)
      );

      if (isDuplicate) {
        appLog('⚠️ Duplicate message received, skipping');
        return;
      }

      chatMessagesList.add(newMessage);
      chatMessagesList.refresh();

      // ✅ Auto scroll to bottom for new messages
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });

      appLog('✅ New message added to chat list');
    } catch (e) {
      errorLog("❌ chatMessageSocketHandler error: $e");
    }
  }

  // ✅ Socket connection setup করার জন্য improved method
  void setupSocketConnection() {
    try {
      if (chatId.isEmpty) {
        appLog('❌ Cannot setup socket - chatId is empty');
        return;
      }

      // ✅ আগের event remove করুন যদি থাকে
      if (currentSocketEvent != null) {
        appLog('🔄 Removing previous socket event: $currentSocketEvent');
        // appSocketAllOperation.removeEvent(currentSocketEvent!);
      }

      currentSocketEvent = "message::$chatId";

      appLog('🔌 Setting up socket connection...');
      appLog('📡 Socket event: $currentSocketEvent');

      // ✅ Socket connection status check
      if (appSocketAllOperation.isConnected) {
        appLog('✅ Socket is already connected');
        isSocketConnected.value = true;
      } else {
        appLog('⚠️ Socket is not connected, attempting to connect...');
        // আপনার socket connection method call করুন
        // appSocketAllOperation.connect();
      }

      // ✅ Event listener setup
      appSocketAllOperation.readEvent(
        event: currentSocketEvent!,
        handler: (data) {
          appLog('📨 Socket event received: $data');
          chatMessageSocketHandler(data);
        },
      );

      // ✅ Connection status listener (যদি available থাকে)
      appSocketAllOperation.readEvent(
        event: "connect",
        handler: (data) {
          appLog('✅ Socket connected successfully');
          isSocketConnected.value = true;
        },
      );

      appSocketAllOperation.readEvent(
        event: "disconnect",
        handler: (data) {
          appLog('❌ Socket disconnected');
          isSocketConnected.value = false;
        },
      );

      appLog('✅ Socket event listeners setup completed');

    } catch (e) {
      errorLog('❌ setupSocketConnection error: $e');
      isSocketConnected.value = false;
    }
  }

  // ✅ Improved pagination with proper scroll detection
  void setupPagination() {
    try {
      scrollController.addListener(() {
        // ✅ শুধুমাত্র যখন top এ scroll করবে তখনই pagination load করুন
        if (scrollController.position.pixels <= scrollController.position.minScrollExtent + 200 &&
            !isPagination.value &&
            !isLast &&
            !isLoading.value) {

          appLog('📄 Loading more messages (pagination)...');
          isPagination.value = true;
          fetchChatMessages();
        }
      });
      appLog('✅ Pagination setup completed');
    } catch (e) {
      errorLog('❌ setupPagination error: $e');
    }
  }

  Future<void> onAppInitialDataLoad() async {
    try {
      appLog('🚀 Initializing chat screen...');

      isLoading.value = true;
      isPagination.value = false;

      final argData = Get.arguments;

      if (argData != null && argData is Map) {
        final ChatModel chat = argData['chat'] as ChatModel;
        final String requestId = argData['requestId'].toString();

        appLog('📋 Request ID: $requestId');
        appLog('💬 Chat ID: ${chat.chatId}');

        // ✅ Data assignment
        chatId = chat.chatId;
        this.requestId = requestId;

        // ✅ Controllers initialization
        scrollController = ScrollController();
        messageController = TextEditingController();

        // ✅ Reset data
        chatMessagesList.clear();
        currentPage = 1;
        isLast = false;

        // ✅ Load initial messages
        await fetchChatMessages();

        // ✅ Socket connection setup - messages load হওয়ার পর
        await Future.delayed(const Duration(milliseconds: 500));
        setupSocketConnection();

        // ✅ Pagination setup
        setupPagination();

        appLog('✅ Chat initialization completed successfully');

      } else {
        appLog('❌ Chat arguments not found');
        Get.snackbar('Error', 'Chat data not found');
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.back();
        });
      }
    } catch (e) {
      errorLog('❌ onAppInitialDataLoad error: $e');
      Get.snackbar('Error', 'Failed to initialize chat');
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Socket connection test করার জন্য method
  void testSocketConnection() {
    try {
      appLog('🧪 Testing socket connection...');

      if (chatId.isEmpty) {
        appLog('❌ Cannot test - chatId is empty');
        return;
      }

      // ✅ Test message send
      final testEvent = "test::$chatId";
      appLog('📡 Sending test event: $testEvent');

      // যদি আপনার socket এ emit method থাকে
      // appSocketAllOperation.emit(testEvent, {'test': 'data'});

    } catch (e) {
      errorLog('❌ testSocketConnection error: $e');
    }
  }

  void onAppClose() {
    try {
      appLog('🔄 Cleaning up chat controller...');

      // ✅ Socket event cleanup
      if (currentSocketEvent != null) {
        appLog('🗑️ Removing socket event: $currentSocketEvent');
        // appSocketAllOperation.removeEvent(currentSocketEvent!);
      }

      // ✅ Controllers cleanup
      messageController.dispose();
      scrollController.dispose();

      appLog('✅ Chat controller cleanup completed');
    } catch (e) {
      errorLog('❌ onAppClose error: $e');
    }
  }

  @override
  void onInit() {
    appLog('🎯 UserChatController onInit called');
    onAppInitialDataLoad();
    super.onInit();
  }

  @override
  void onClose() {
    appLog('🔚 UserChatController onClose called');
    images.clear();
    onAppClose();
    super.onClose();
  }
}*/



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
          0, ChatMessageResponseModel.fromJson(message));
      // chatMessages.add(ChatMessageResponseModel.fromJson(message));
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
        final ChatModel chat = argData['chat'] as ChatModel; // এখানে cast করতে হবে
        final String requestId = argData['requestId'].toString();

        appLog('request id👌👌→→→===>> $requestId');
        appLog('chat data😥😥😥 ===>> ${chat.chatId}'); // debug করলে ভালো দেখা যাবে

        chatId = chat.chatId;   // এখন ChatModel থেকে access করা যাবে
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
