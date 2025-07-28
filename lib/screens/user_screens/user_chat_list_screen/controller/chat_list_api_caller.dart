
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';
import '../../../../constants/api_urls.dart';
import '../../../../models/request_list_model.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../user_chat_list_proposal_screen/controller.dart';

class RequestListController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  List<Request> _originalRequestList = [];
  List<Request> _filteredRequestList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Request> get requestList => _filteredRequestList;

  Future<bool> fetchRequestList() async {
    _isLoading = true;
    update();

    final response = await ApiService.getApi(
      ApiUrls.chatListUrl,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
      },
    );

    bool isSuccess = false;

    if (response.statusCode == 200) {
      try {
        final List dataList = response.body['data']['data'];
        _originalRequestList =
            dataList.map((item) => Request.fromJson(item)).toList();
        _filteredRequestList = _originalRequestList;
        _errorMessage = null;
        isSuccess = true;

        if (_originalRequestList.isNotEmpty) {
          Get.find<ChatController>().setId(_originalRequestList[0].id);
        }
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

  void filterList(String query) {
    if (query.isEmpty) {
      _filteredRequestList = _originalRequestList;
    } else {
      _filteredRequestList = _originalRequestList.where((request) {
        return request.message.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  Future<void> refreshRequestList() async {
    _originalRequestList = [];
    await fetchRequestList();
    update();
  }
}

