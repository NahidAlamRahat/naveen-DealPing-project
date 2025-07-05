import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:get/get.dart';

import '../../../../models/request_list_model.dart';

class RequestListController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  List<Request> _requestList = [];

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<Request> get requestList => _requestList;

  Future<bool> fetchRequestList() async {
    _isLoading = true;
    update();

    final response = await ApiService.getApi(
      ApiUrls.chatListUrl,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
      },
    ); // URL ঠিক করো

    print("response status code ${response.statusCode}");

    bool isSuccess = false;

    if (response.statusCode == 200) {
      try {
        final List dataList = response.body['data']['data'];
        _requestList = dataList.map((item) => Request.fromJson(item)).toList();
        _errorMessage = null;
        isSuccess = true;
      } catch (e) {
        _errorMessage = "Data parsing error";
      }
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<void> refreshRequestList() async {
    _requestList = [];
    await fetchRequestList();
  }
}
