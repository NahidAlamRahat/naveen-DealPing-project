
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../constants/api_urls.dart';
import '../../../../models/notification_model.dart';
import '../../../../utils/app_log/app_log.dart';

class UserNotificationApiCallerController extends GetxController {

  final int _perPageDataCount = 10;
  int _currentPage = 1;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  String? _errorMessage;



  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  // List<NotificationModel> get notificationList => _notificationList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  Future< List<NotificationModel>> getNotificationList() async {

    // if (_totalPage != null && _currentPage > _totalPage!) return [];
    // _currentPage++;
    //
    // if (!_isInitialLoading) _isLoading = true;
    update();


    final response = await ApiService.getApi(ApiUrls.userNotificationsUrl, queryParams: {
      // 'count': _perPageDataCount,
      'page': _currentPage,
    });

    appLog('url $_currentPage, $_currentPage userNotificationsUrl😊😊😊😊😊===>  ${ApiUrls.userNotificationsUrl}');

    if (response.statusCode == 200) {
      appLog('notificationList statusCode ===>  ${response.statusCode}');

      final body = response.body['data']; // ✅ Corrected
      appLog('notificationList 😊😊😊😊😊===>  ${body['data']}');

     return List.from( body['data']).map((item)=> NotificationModel.fromJson(item)).toList();
    } else {
      _errorMessage = response.message;
      debugPrint('_errorMessage ===>  ${response.message}');
    }

    _isInitialLoading = false;
    _isLoading = false;
    update();
    return [];
  }

  Future< List<NotificationModel>> refreshList() async {
    _currentPage = 1;
    // _notificationList.clear();
    _isInitialLoading = true;
    return getNotificationList();
  }

  // Future<void> appOnInit() async {
  //   try {
  //     await getNotificationList();
  //   } catch (e) {
  //     debugPrint('error from ${e.toString()}');
  //   }
  // }

  @override
  void onInit() {
    // appOnInit();
    super.onInit();
  }
}