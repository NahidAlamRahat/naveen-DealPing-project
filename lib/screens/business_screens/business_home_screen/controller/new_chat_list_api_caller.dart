import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/screens/business_screens/business_home_screen/model/business_chat_list_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../utils/app_log/error_log.dart';

enum ChatType{New, Ongoing, Completed}

class BusinessChatListApiController extends GetxController {
  ChatType selectedChatType = ChatType.New;
  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  late RxList _businessChatList = [].obs;
  List<BusinessesChatListModel> _originalRequestList = [];

  // Add search query tracking
  String _currentSearchQuery = '';

  AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  RxList get businessChatList => _businessChatList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  void onChatTypeChange(int index){
    selectedChatType = ChatType.values.elementAt(index);
    // Reset search when changing tabs
    _currentSearchQuery = '';
    update();
  }

  void filterList(String query) {
    print('Query: $query');
    _currentSearchQuery = query; // Store current search query

    if (query.isEmpty) {
      print('❤️❤️Resetting full list');
      _businessChatList.value = List.from(_originalRequestList); // Create new list
    } else {
      final filtered = _originalRequestList.where((request) {
        print('Checking: ${request.participant?.name}');
        return (request.participant?.name??'')
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      print('Filtered count: ${filtered.length}');
      _businessChatList.value = filtered;
    }
    _businessChatList.refresh(); // Force UI update
  }

  Future<bool> getChatList() async {
    if (_totalPage != null && _currentPage > _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    final response = await ApiService.getApi(
        ApiUrls.businessChatListUrl(
          status: selectedChatType.name.toLowerCase(),
        ),
        queryParams: {
          'count': _perPageDataCount,
          'page': _currentPage,
        });

    appLog('url 😊😊😊😊😊===>  ${ApiUrls.businessChatListUrl(
      status: selectedChatType.name.toLowerCase(),
    )}');

    if (response.statusCode == 200) {
      appLog('response ===>  ${response.body}');
      List<BusinessesChatListModel> list = [];

      final body = response.body['data'];
      for (Map<String, dynamic> data in body['data']) {
        list.add(BusinessesChatListModel.fromJson(data));
      }

      _businessChatList.addAll(list);
      _originalRequestList.addAll(list);

      _totalPage = body['meta']['totalPages'];
      _errorMessage = null;
      isSuccess = true;

      // Apply current search filter if exists
      if (_currentSearchQuery.isNotEmpty) {
        filterList(_currentSearchQuery);
      }

      appLog('Fetched bookings: ${_businessChatList.length}');
    } else {
      _errorMessage = response.message;
      debugPrint('_errorMessage ===>  ${response.message}');
    }

    _isInitialLoading = false;
    _isLoading = false;
    update();
    return isSuccess;
  }

  // ✅ NEW: Real-time message update handler for socket
  void handleRealTimeMessageUpdate(dynamic messageData) {
    try {
      appLog('🚀 Real-time message update received: $messageData');

      // Extract data from different possible socket structures
      String chatId = '';
      String newMessage = '';
      String senderId = '';

      // Handle different socket data structures
      if (messageData is Map<String, dynamic>) {
        // Check for nested 'data' object
        final data = messageData['data'] ?? messageData;

        chatId = data['chatId'] ??
            data['chat_id'] ??
            data['id'] ??
            (data['chat'] != null ? data['chat']['id'] : '') ?? '';

        newMessage = data['message'] ??
            data['text'] ??
            data['latestMessage'] ??
            'New message';

        senderId = data['sender']?['id'] ??
            data['senderId'] ??
            data['user_id'] ?? '';
      }

      if (chatId.isEmpty) {
        appLog('❌ Chat ID not found in message data, trying to extract from structure');
        appLog('Available keys: ${messageData.keys}');
        return;
      }

      // Find existing chat in original list
      int originalIndex = _originalRequestList.indexWhere(
              (chat) => chat.id == chatId
      );

      if (originalIndex != -1) {
        // ✅ Chat exists - update latest message and move to top
        BusinessesChatListModel existingChat = _originalRequestList[originalIndex];

        // Create updated chat model - you might need to adjust this based on your model constructor
        BusinessesChatListModel updatedChat;
        try {
          updatedChat = BusinessesChatListModel(
            id: existingChat.id,
            participant: existingChat.participant,
            latestMessage: newMessage,
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            unreadMessageCount: senderId != LocalStorage.userId
                ? existingChat.unreadMessageCount! + 1
                : existingChat.unreadMessageCount,
            requests: existingChat.requests,
            latestStatusMessage: existingChat.latestStatusMessage,
          );
        } catch (e) {
          // Fallback: create a copy with modified fields
          updatedChat = existingChat;
          // If your model has a copyWith method, use it:
          // updatedChat = existingChat.copyWith(
          //   latestMessage: newMessage,
          //   updatedAt: DateTime.now().toIso8601String(),
          // );
        }

        // Remove from current position and add to top of original list
        _originalRequestList.removeAt(originalIndex);
        _originalRequestList.insert(0, updatedChat);

        // Update displayed list
        int displayedIndex = _businessChatList.indexWhere(
                (chat) => chat.id == chatId
        );

        if (displayedIndex != -1) {
          _businessChatList.removeAt(displayedIndex);
        }

        // Apply current filter and add to top
        if (_currentSearchQuery.isEmpty) {
          _businessChatList.insert(0, updatedChat);
        } else {
          // Re-apply the current filter to include updated chat
          filterList(_currentSearchQuery);
        }

        _businessChatList.refresh();
        appLog('✅ Chat list updated real-time for chatId: $chatId');
        appLog('✅ New latest message: $newMessage');
        appLog('✅ Chat moved to top of list');
      } else {
        appLog('⚠️ Chat not found in list for real-time update: $chatId');
        // Optionally refresh the entire list to get new chats
        // refreshList();
      }

    } catch (e) {
      errorLog("handleRealTimeMessageUpdate error: $e");
    }
  }

  void businessChatSocketHandler(dynamic data) {
    try {
      final businessesChatListModel = BusinessesChatListModel.fromJson(data);

      if (businessesChatListModel.id!.isEmpty ||
          businessesChatListModel.participant!.id!.isEmpty) return;

      // Check if chat already exists in the list
      int existingIndex = _originalRequestList.indexWhere(
              (chat) => chat.id == businessesChatListModel.id
      );

      if (existingIndex != -1) {
        // ✅ Chat exists - update latest message and move to top
        _originalRequestList.removeAt(existingIndex);
        _originalRequestList.insert(0, businessesChatListModel);

        // Update the displayed list as well
        int displayedIndex = _businessChatList.indexWhere(
                (chat) => chat.id == businessesChatListModel.id
        );

        if (displayedIndex != -1) {
          _businessChatList.removeAt(displayedIndex);
        }

        // Apply filter if search is active
        if (_currentSearchQuery.isEmpty) {
          _businessChatList.insert(0, businessesChatListModel);
        } else {
          // Re-apply the current filter to include updated chat
          filterList(_currentSearchQuery);
        }
      } else {
        // ✅ New chat - add to top of both lists
        _originalRequestList.insert(0, businessesChatListModel);

        // Apply filter if search is active
        if (_currentSearchQuery.isEmpty) {
          _businessChatList.insert(0, businessesChatListModel);
        } else {
          // Re-apply the current filter
          filterList(_currentSearchQuery);
        }
      }

      _businessChatList.refresh();
      appLog('Chat updated/added: ${businessesChatListModel.participant?.name}');
    } catch (e) {
      errorLog("businessChatSocketHandler $e");
    }
  }

  Future<bool> refreshList() async {
    _currentPage = 0;
    _businessChatList.clear();
    _originalRequestList.clear(); // Clear original list too
    _isInitialLoading = true;
    // Keep the current search query during refresh
    return getChatList();
  }

  // Add method to clear search
  void clearSearch() {
    _currentSearchQuery = '';
    _businessChatList.value = List.from(_originalRequestList);
    _businessChatList.refresh();
  }

  Future<void> appOnInit() async {
    try {
      await getChatList();

      appLog('socet busness user id  ==== ${LocalStorage.userId}');
      appLog('socet busness user token   ==== ${LocalStorage.token}');

      // ✅ Listen for new chat events
      appSocketAllOperation.readEvent(
          event: "newChat::${LocalStorage.userId}",
          handler: (data) {
            appLog('socet data ==== $data');
            businessChatSocketHandler(data);
            appLog('👌👌👌👌new business chat==>>> ${data}  ');
          });

      // ✅ NEW: Listen for all message events to update latest message in real-time
      appSocketAllOperation.readEvent(
          event: "message::${LocalStorage.userId}",
          handler: (data) {
            appLog('🚀 Real-time message socket data: $data');
            handleRealTimeMessageUpdate(data);
            appLog('👌👌👌👌real-time message update: $data');
          });

      // ✅ NEW: Alternative event listener for user-specific messages
      appSocketAllOperation.readEvent(
          event: "userMessages::${LocalStorage.userId}",
          handler: (data) {
            appLog('🚀 User messages socket data: $data');
            handleRealTimeMessageUpdate(data);
            appLog('👌👌👌👌user messages update: $data');
          });

      // ✅ NEW: Listen for business-specific message updates
      appSocketAllOperation.readEvent(
          event: "businessMessageUpdate::${LocalStorage.userId}",
          handler: (data) {
            appLog('🚀 Business message update socket data: $data');
            handleRealTimeMessageUpdate(data);
            appLog('👌👌👌👌business message update: $data');
          });

    } catch (e) {
      debugPrint('error from ${e.toString()}');
    }
  }

  @override
  void onInit() {
    appOnInit();
    super.onInit();
  }

  @override
  void onClose() {
    // Clean up when controller is disposed
    _businessChatList.clear();
    _originalRequestList.clear();
    super.onClose();
  }
}