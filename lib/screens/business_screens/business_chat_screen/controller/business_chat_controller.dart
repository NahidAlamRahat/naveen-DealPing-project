import 'package:deal_ping/screens/business_screens/business_home_screen/model/business_chat_list_model.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/error_log.dart';
import '../../business_home_screen/controller/new_chat_list_api_caller.dart';

class BusinessChatController extends GetxController {
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
  ChatType? currentChatType; // ✅ Add this to store current chat type

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

  // ✅ Helper method to get status string from ChatType
  String getChatTypeStatus(ChatType? chatType) {
    switch (chatType) {
      case ChatType.New:
        return 'new';
      case ChatType.Ongoing:
        return 'ongoing';
      case ChatType.Completed:
        return 'completed';
      default:
        return 'new'; // Default fallback
    }
  }

  Future<void> fetchChatMessages() async {
    try {
      if (isLast) {
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

      // ✅ Fixed: Use chatType to determine status
      final data = await commonRepository.getBusinessChatMessage(
          page: currentPage,
          chatId: chatId,
          status: getChatTypeStatus(currentChatType) // ✅ Use the helper method
      );

      if (data.isNotEmpty) {
        chatMessagesList.addAll(data);
        chatMessagesList.refresh();
        currentPage++;
      } else {
        isLast = true;
      }
    } catch (e) {
      errorLog('fetchChatMessages errorLog=====>$e');
    }
    isLoading.value = false;
    isPagination.value = false;
  }

  // ✅ NEW: Method to trigger real-time chat list update via socket
  void _triggerChatListUpdate(String message) {
    try {
      final updateData = {
        'chatId': chatId,
        'message': message,
        'senderId': LocalStorage.userId,
        'timestamp': DateTime.now().toIso8601String(),
        'type': 'message_update',
        'data': {
          'id': chatId,
          'message': message,
          'sender': {
            'id': LocalStorage.userId,
          },
          'createdAt': DateTime.now().toIso8601String(),
        }
      };

      appLog('🚀 Triggering chat list update via socket: $message');

      // Emit socket event that the chat list controller will catch
      appSocketAllOperation.emitEvent('messageUpdate::${LocalStorage.userId}', updateData);

      // Also update local chat list controller if it exists
      if (Get.isRegistered<BusinessChatListApiController>()) {
        final chatListController = Get.find<BusinessChatListApiController>();
        chatListController.handleRealTimeMessageUpdate(updateData);
      }

    } catch (e) {
      errorLog("_triggerChatListUpdate error: $e");
    }
  }

  Future<void> sendOffer({
    required String offerTitle,
    required String offerDescription,
  }) async {
    try {
      isMessageSent = true;
      update();
      await commonRepository.sendOffer(
        offerTitle: offerTitle,
        // offerDescription: offerDescription,
        chatId: chatId,
        requestId: requestId,
      );
      appLog('Offer sent for requestId: $requestId');
      appLog('Offer sent for chatId: $chatId');

      // ✅ NEW: Trigger real-time chat list update
      _triggerChatListUpdate("📋 $offerTitle");

    } catch (e) {
      errorLog("send Offer method ===>> $e");
    }
    isMessageSent = false;
    update();
  }

  Future<void> sendMessage() async {
    try {
      if (messageController.text.trim().isEmpty && images.isEmpty) return;
      if (isMessageSent) return;

      isMessageSent = true;
      update();

      // ✅ Store message for chat list update
      String messageText = messageController.text.trim();
      bool hasImages = images.isNotEmpty;

      var response = await commonRepository.sendMessage(
        message: messageText,
        requestId: requestId,
        imageUrl: images,
        chatId: chatId,
      );

      if (response != null) {
        // Create display message for chat list
        String displayMessage = messageText;
        if (hasImages && messageText.isEmpty) {
          displayMessage = "📷 Photo";
        } else if (hasImages && messageText.isNotEmpty) {
          displayMessage = "📷 $messageText";
        }

        // ✅ NEW: Trigger real-time chat list update
        _triggerChatListUpdate(displayMessage);

        // Clear inputs
        messageController.clear();
        images.clear();
        images.refresh();
        update();
      }
    } catch (e) {
      errorLog('sendMessage errorLog=====>$e');
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
    } catch (e) {
      errorLog("scrollToBottom========>>>  $e");
    }
  }

  void chatMessageSocketHandler(dynamic message) {
    try {
      chatMessagesList.insert(
          0, ChatMessageResponseModel.fromJson(message['data']));
      chatMessagesList.refresh();

      // ✅ NEW: If message is from someone else, update chat list
      final newMessage = ChatMessageResponseModel.fromJson(message['data']);
      if (newMessage.sender?.id != LocalStorage.userId) {
        _triggerChatListUpdate(newMessage.message ?? "New message");
      }

      appLog('Message received and chat list updated');
    } catch (e) {
      errorLog("chatMessageSocketHandler $e");
    }
  }

  void paginationData() {
    try {
      scrollController.addListener(() {
        // ✅ Fixed pagination logic
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) {
          if (!isPagination.value && !isLast) {
            appLog('Loading more messages...');
            isPagination.value = true;
            fetchChatMessages();
          }
        }
      });
    } catch (e) {
      errorLog('paginationData error: $e');
    }
  }

  Future<void> onAppInitialDataLoad() async {
    try {
      isLoading.value = true;
      isPagination.value = false;

      final argData = Get.arguments;
      appLog('Received arguments: $argData');

      if (argData != null) {
        BusinessesChatListModel? chatData;
        ChatType? chatType;

        // Handle new argument structure
        if (argData is Map<String, dynamic>) {
          chatData = argData['chatData'] as BusinessesChatListModel?;
          chatType = argData['chatType'] as ChatType?;

          // ✅ Store chatType for later use
          currentChatType = chatType;

          if (chatData != null) {
            chatId = chatData.id!;

            // Smart request ID selection based on chat type
            if (chatData.requests!.isNotEmpty) {
              switch (chatType) {
                case ChatType.New:
                // For new chats, prefer the request from latestStatusMessage
                  requestId = chatData.latestStatusMessage?.request ?? chatData.requests?.last??'';
                  break;
                case ChatType.Ongoing:
                // For ongoing, use the most recent request
                  requestId = chatData.requests?.last??'';
                  break;
                case ChatType.Completed:
                // For completed, use the first request
                  requestId = chatData.requests?.first??'';
                  break;
                default:
                  requestId = chatData.requests?.last??"";
              }
            } else {
              requestId = chatId; // Fallback
            }

            appLog('Navigation Details:');
            appLog('- Chat Type: $chatType');
            appLog('- Chat Type Status: ${getChatTypeStatus(chatType)}'); // ✅ Log status string
            appLog('- Chat ID: $chatId');
            appLog('- Request ID: $requestId');
            appLog('- Available requests: ${chatData.requests}');
            appLog('- Latest status message request: ${chatData.latestStatusMessage?.request}');
          }
        }

        // Keep existing fallback logic for backward compatibility
        else if (argData is BusinessesChatListModel) {
          requestId = argData.latestStatusMessage?.request ?? '';
          chatId = argData.id!;
          currentChatType = ChatType.New; // ✅ Default fallback
          appLog('Fallback: BusinessesChatListModel used');
        } else if (argData is String) {
          chatId = argData;
          requestId = argData;
          currentChatType = ChatType.New; // ✅ Default fallback
          appLog('Fallback: String used');
        } else if (argData is Map) {
          chatId = argData['chatId'] ?? '';
          requestId = argData['requestId'] ?? argData['chatId'] ?? '';
          currentChatType = ChatType.New; // ✅ Default fallback
          appLog('Fallback: Map used');
        }

        if (chatId.isNotEmpty) {
          // Reset controllers
          scrollController = ScrollController();
          messageController = TextEditingController();

          chatMessagesList.clear();
          currentPage = 1;
          isLast = false;

          // Setup socket listener
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

          // Setup pagination
          paginationData();

          // Check if user has replied
          checkIfUserReplied();
        } else {
          errorLog("Chat ID is empty or invalid");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.back();
          });
        }
      } else {
        errorLog("No arguments provided");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.back();
        });
      }
    } catch (e) {
      errorLog('onAppInitialDataLoad error: $e');
    }
  }

  void onAppClose() {
    try {
      messageController.dispose();
      scrollController.dispose();

      // ✅ Cleanup socket listener
      if (chatId.isNotEmpty) {
        // appSocketAllOperation.emitEvent();
      }
    } catch (e) {
      errorLog('onAppClose errorLog=====>$e');
    }
  }

  @override
  void onInit() {
    appLog('BusinessChatController onInit called');
    onAppInitialDataLoad();
    scrollToBottom();
    super.onInit();
  }

  @override
  void onClose() {
    images.clear();
    onAppClose();
    super.onClose();
  }
}
