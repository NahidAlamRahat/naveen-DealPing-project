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
        print('Checking: ${request.participant.name}');
        return (request.participant.name)
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

  void businessChatSocketHandler(dynamic data) {
    try {
      final businessesChatListModel = BusinessesChatListModel.fromJson(data);

      if (businessesChatListModel.id.isEmpty ||
          businessesChatListModel.participant.id.isEmpty) return;

      // Add to both lists
      _originalRequestList.insert(0, businessesChatListModel);

      // Apply filter if search is active
      if (_currentSearchQuery.isEmpty) {
        businessChatList.insert(0, businessesChatListModel);
      } else {
        // Re-apply the current filter
        filterList(_currentSearchQuery);
      }

      _businessChatList.refresh();
    } catch (e) {
      errorLog("notificationSocketHandler $e");
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

      appSocketAllOperation.readEvent(
          event: "newChat::${LocalStorage.userId}",
          handler: (data) {
            appLog('socet data ==== $data');
            businessChatSocketHandler(data);
            appLog('👌👌👌👌new business chat==>>> ${data}  ');
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