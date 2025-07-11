/*
import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/booking_list_model.dart';

class CategoryController extends GetxController {
  final int _perPageDataCount = 30;

  int _currentPage = 1;

  int? _totalPage;

  bool _isInitialLoading = true;

  bool _isLoading = false;

  List<BookingModel> _bookingList = [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  int? get totalPage => _totalPage;

  List<BookingModel> get bookingList => _bookingList;

  bool get isLoading => _isLoading;

  bool get isInitialLoading => _isInitialLoading;

  Future<bool> getCategoryList() async {
    // If current page exceeds total pages, stop fetching
    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) {
      _isLoading = true;
    }
    update();

    // Fetch the booking data
    final response =
        await ApiService.getApi(ApiUrls.bookingListUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
    });
    print('url ===>  ${ApiUrls.bookingListUrl}');

    if (response.statusCode == 200) {
      print('statusCode ===>  ${response.statusCode}');

      List<BookingModel> list = [];
      // Fixing the data extraction based on your API response structure
      for (Map<String, dynamic> data in response.body['data']) {
        list.add(BookingModel.fromJson(
            data)); // Make sure the response body structure is correctly used
      }

      // Adding fetched bookings to the list
      _bookingList.addAll(list);

      // Set the total pages for pagination
      _totalPage = response.body['data']['meta']['totalPages'];

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.message; // Ensure this is being set correctly

      debugPrint('_errorMessage ===>  ${response.message}');
    }

    // Reset loading states
    if (!_isInitialLoading) {
      _isLoading = false;
    } else {
      _isInitialLoading = false;
    }

    update();
    return isSuccess;
  }

  // Method to refresh the list (reset page and clear data)
  Future<bool> refreshList() async {
    _currentPage = 1; // Reset current page to 1 for refreshing
    _bookingList.clear(); // Clear the old data
    _isInitialLoading = true; // Set initial loading state
    return getCategoryList(); // Call the method to get data
  }

  Future<void> appOnInit() async {
    try {
      await getCategoryList();
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
*/

//===========================================


import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/booking_list_model.dart';

class BookingListController extends GetxController {
  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isInitialLoading = true;
  bool _isLoading = false;
  List<BookingModel> _bookingList = [];
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List<BookingModel> get bookingList => _bookingList;
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;

  Future<bool> getBookingList() async {
    if (_totalPage != null && _currentPage > _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    final response = await ApiService.getApi(ApiUrls.bookingListUrl, queryParams: {
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
    _currentPage = 1;
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

