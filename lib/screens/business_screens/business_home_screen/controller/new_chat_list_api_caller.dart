/*
import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/screens/business_screens/business_home_screen/model/business_chat_list_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../utils/app_log/app_log.dart';

enum ChatType{New, Ongoing, Completed}

class BusinessChatListApiController extends GetxController {
  ChatType selectedChatType = ChatType.New;
  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  late List<BusinessesChatListModel> _businessChatList = [];
  List<BusinessesChatListModel> _originalRequestList = [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List<BusinessesChatListModel> get businessChatList => _businessChatList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  void onChatTypeChange(int index){
    selectedChatType = ChatType.values.elementAt(index);
    update();
  }


  void filterList(String query) {
    print('Query: $query');
    if (query.isEmpty) {
      print('❤️❤️Resetting full list');
      _businessChatList = _originalRequestList;
    } else {
      final filtered = _originalRequestList.where((request) {
        print('Checking: ${request.participant.name}');
        return (request.participant.name ?? '')
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      print('Filtered count: ${filtered.length}');
      _businessChatList = filtered;
    }
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

      final body = response.body['data']; // ✅ Corrected
      for (Map<String, dynamic> data in body['data']) {
        list.add(BusinessesChatListModel.fromJson(data));
      }

      _businessChatList.addAll(list);
      _originalRequestList.addAll(list);

      _totalPage = body['meta']['totalPages']; // ✅ Corrected
      _errorMessage = null;
      isSuccess = true;

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


  Future<bool> refreshList() async {
    _currentPage = 0;
    _businessChatList.clear();
    _isInitialLoading = true;
    return getChatList();
  }


  Future<void> appOnInit() async {
    try {
      await getChatList();
    } catch (e) {
      debugPrint('error from ${e.toString()}');
    }
  }

  @override
  void onInit() {
    appOnInit();
    super.onInit();
  }
}*/





import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/screens/business_screens/business_home_screen/model/business_chat_list_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../utils/app_log/app_log.dart';

enum ChatType { New, Ongoing, Completed }

extension ChatTypeExtension on ChatType {
  String get apiValue {
    switch (this) {
      case ChatType.New:
        return 'new';
      case ChatType.Ongoing:
        return 'ongoing';
      case ChatType.Completed:
        return 'completed';
    }
  }

  String get displayName {
    switch (this) {
      case ChatType.New:
        return 'New\nmessage';
      case ChatType.Ongoing:
        return 'Ongoing\nmessage';
      case ChatType.Completed:
        return 'Completed\nmessage';
    }
  }
}

class BusinessChatListApiController extends GetxController {
  ChatType selectedChatType = ChatType.New;
  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  late List<BusinessesChatListModel> _businessChatList = [];
  List<BusinessesChatListModel> _originalRequestList = [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List<BusinessesChatListModel> get businessChatList => _businessChatList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  void onChatTypeChange(int index) {
    selectedChatType = ChatType.values.elementAt(index);
    appLog('Selected chat type: ${selectedChatType.apiValue}');
    update();
  }

  void filterList(String query) {
    appLog('Query: $query');
    if (query.isEmpty) {
      appLog('❤️❤️Resetting full list');
      _businessChatList = List.from(_originalRequestList);
    } else {
      final filtered = _originalRequestList.where((request) {
        appLog('Checking: ${request.participant.name}');
        return (request.participant.name ?? '')
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      appLog('Filtered count: ${filtered.length}');
      _businessChatList = filtered;
    }
    update(); // ✅ Add this to refresh UI
  }

  Future<bool> getChatList() async {
    if (_totalPage != null && _currentPage >= _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    try {
      // ✅ Fixed URL construction
      final url = "${ApiUrls.baseUrl}/chat/businesses";

      final response = await ApiService.getApi(
        url,
        queryParams: {
          'status': selectedChatType.apiValue, // ✅ Use extension method
          'count': _perPageDataCount,
          'page': _currentPage,
        },
      );

      appLog('Request URL: $url?status=${selectedChatType.apiValue}&count=$_perPageDataCount&page=$_currentPage');

      if (response.statusCode == 200) {
        appLog('Response body: ${response.body}');

        List<BusinessesChatListModel> list = [];

        // ✅ Handle response structure properly
        final responseData = response.body;

        if (responseData['data'] != null && responseData['data'] is List) {
          for (Map<String, dynamic> data in responseData['data']) {
            list.add(BusinessesChatListModel.fromJson(data));
          }

          _businessChatList.addAll(list);
          _originalRequestList.addAll(list);

          // ✅ Handle pagination meta if available
          if (responseData['meta'] != null) {
            _totalPage = responseData['meta']['totalPages'];
          } else {
            // ✅ Fallback pagination logic
            if (list.length < _perPageDataCount) {
              _totalPage = _currentPage;
            }
          }

          _errorMessage = null;
          isSuccess = true;

          appLog('Fetched chats: ${_businessChatList.length}');
        } else {
          _errorMessage = 'Invalid response structure';
          appLog('Invalid response structure: ${responseData}');
        }
      } else {
        _errorMessage = response.message ?? 'Failed to fetch chat list';
        appLog('API Error: ${response.message}');
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      appLog('Exception in getChatList: $e');
    }

    _isInitialLoading = false;
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> refreshList() async {
    _currentPage = 0;
    _totalPage = null; // ✅ Reset total page
    _businessChatList.clear();
    _originalRequestList.clear(); // ✅ Clear original list too
    _isInitialLoading = true;
    _errorMessage = null; // ✅ Clear any previous errors
    return await getChatList();
  }

  Future<void> appOnInit() async {
    try {
      await getChatList();
    } catch (e) {
      _errorMessage = 'Initialization error: ${e.toString()}';
      appLog('Error from appOnInit: ${e.toString()}');
      update();
    }
  }

  @override
  void onInit() {
    appOnInit();
    super.onInit();
  }

  @override
  void onClose() {
    _businessChatList.clear();
    _originalRequestList.clear();
    super.onClose();
  }
}