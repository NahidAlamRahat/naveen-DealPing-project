
import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../models/booking_list_model.dart';


enum BookingStatus{upcoming, completed}

class BookingListController extends GetxController {

  BookingStatus bookingStatus = BookingStatus.upcoming;
  final int _perPageDataCount = 10;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  final List<BookingModel> _bookingList = [];
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List<BookingModel> get bookingList => _bookingList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;



  void onBookingStatusChange(int index){
    bookingStatus = BookingStatus.values.elementAt(index);
  }

  Future<bool> getBookingList() async {
    if (_totalPage != null && _currentPage > _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    final response = await ApiService.getApi(ApiUrls.bookingListUrl(longitude:  90.4125, latitude:  23.8103, status: bookingStatus), queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
    });


    print('url 😊😊😊😊😊===>  ${ApiUrls.bookingListUrl}');

    if (response.statusCode == 200) {
      print('statusCode ===>  ${response.statusCode}');
      List<BookingModel> list = [];

      final body = response.body['data']; // ✅ Corrected
      for (Map<String, dynamic> data in body['data']) {
        list.add(BookingModel.fromJson(data));
      }

      _bookingList.addAll(list);
      _totalPage = body['meta']['totalPages']; // ✅ Corrected
      _errorMessage = null;
      isSuccess = true;

      print('Fetched bookings: ${_bookingList.length}');
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
    _bookingList.clear();
    _isInitialLoading = true;
    return getBookingList();
  }

  Future<void> appOnInit() async {
    try {
      await getBookingList();
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

