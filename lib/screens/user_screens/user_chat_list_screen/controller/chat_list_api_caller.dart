
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
  List<Request> _requestList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Request> get requestList => _requestList;

  // Fetch the list of requests and pass the ID to the ChatController
  Future<bool> fetchRequestList() async {
    _isLoading = true;
    update();

    final response = await ApiService.getApi(
      ApiUrls.chatListUrl,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
      },
    );

    appLog("response status code ${response.statusCode}");

    bool isSuccess = false;

    if (response.statusCode == 200) {
      try {
        final List dataList = response.body['data']['data'];
        _requestList = dataList.map((item) => Request.fromJson(item)).toList();
        _errorMessage = null;
        isSuccess = true;

        appLog('😒😒😒===>>>>${_requestList[0].id}');// Passing the ID to ChatController

        // Assuming you want to pass the `id` of the first request

          // String requestId = _requestList[0].id; // Fetching the ID of the first request
          Get.find<ChatController>().setId(_requestList[0].id);

          // debugPrint('😒😒😒===>>>>$requestId');// Passing the ID to ChatController

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

  // Optionally, you can create a refresh function to re-fetch the data
  Future<void> refreshRequestList() async {
    _requestList = [];
    await fetchRequestList();
  }
}

