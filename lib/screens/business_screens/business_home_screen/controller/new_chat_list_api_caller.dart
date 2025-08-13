import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/screens/business_screens/business_home_screen/model/business_chat_list_model.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
        print('Checking: ${request.name}');
        return (request.name ?? '')
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
}
