
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../constants/api_urls.dart';
import '../../../../models/notification_model.dart';
import '../../../../utils/app_log/app_log.dart';

class UserNotificationApiCallerController extends GetxController {

  final int _perPageDataCount = 10;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  List<NotificationModel> notificationList = [];
  String? _errorMessage;



  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  // List<NotificationModel> get notificationList => _notificationList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  Future<bool> getNotificationList() async {
    if (_totalPage != null && _currentPage > _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    final response = await ApiService.getApi(ApiUrls.userNotificationsUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
    });


    appLog('url userNotificationsUrl😊😊😊😊😊===>  ${ApiUrls.userNotificationsUrl}');

    if (response.statusCode == 200) {
      appLog('notificationList statusCode ===>  ${response.statusCode}');

      final body = response.body['data']; // ✅ Corrected
      appLog('notificationList 😊😊😊😊😊===>  $body');

      for (var item in body['data']) {
        notificationList.add(NotificationModel.fromJson(item));
      }
      appLog('notificationList 😊😊😊😊😊===>  $notificationList');

      // _notificationList.addAll(list);
      _totalPage = body['meta']['totalPages']; // ✅ Corrected
      _errorMessage = null;
      isSuccess = true;

      appLog('Fetched bookings: ${notificationList.length}');
      update();
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
    _currentPage = 1;
    // _notificationList.clear();
    _isInitialLoading = true;
    return getNotificationList();
  }

  Future<void> appOnInit() async {
    try {
      await getNotificationList();
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