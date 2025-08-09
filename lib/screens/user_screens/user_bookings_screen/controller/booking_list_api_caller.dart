
import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../models/booking_list_model.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';


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
  String? _loadingBookingId;
  String? get loadingBookingId => _loadingBookingId;




  void onBookingStatusChange(int index){
    bookingStatus = BookingStatus.values.elementAt(index);
  }

  Future<bool> getBookingList() async {
    if (_totalPage != null && _currentPage > _totalPage!) return true;

    bool isSuccess = false;
    _currentPage++;

    if (!_isInitialLoading) _isLoading = true;
    update();

    final response = await ApiService.getApi(
        ApiUrls.bookingListUrl(
            longitude: 90.4125, latitude: 23.8103, status: bookingStatus),
        queryParams: {
          'count': _perPageDataCount,
      'page': _currentPage,
    });


    appLog('url 😊😊😊😊😊===>  ${ApiUrls.bookingListUrl}');

    if (response.statusCode == 200) {
      appLog('statusCode ===>  ${response.statusCode}');
      List<BookingModel> list = [];

      final body = response.body['data']; // ✅ Corrected
      for (Map<String, dynamic> data in body['data']) {
        list.add(BookingModel.fromJson(data));
      }

      _bookingList.addAll(list);
      _totalPage = body['meta']['totalPages']; // ✅ Corrected
      _errorMessage = null;
      isSuccess = true;

      appLog('Fetched bookings: ${_bookingList.length}');
    } else {
      _errorMessage = response.message;
      appLog('_errorMessage ===>  ${response.message}');
    }

    _isInitialLoading = false;
    _isLoading = false;
    update();
    return isSuccess;
  }



  Future<void> bookingSuccess({required String bookingId}) async {
    _loadingBookingId = bookingId;
    update();

    try {
      final response = await ApiService.patchApi(
        ApiUrls.bookingSuccessUrl(bookingId: bookingId),
      );

      if (response.statusCode == 200) {
        AppSnackBar.success(response.message);
      }
    } catch (e) {
      AppSnackBar.error("Error completing booking: ${e.toString()}");
    } finally {
      _loadingBookingId = null;
      update();
    }
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



//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../../../../constants/api_urls.dart';
// import '../../../../models/booking_list_model.dart';
// import '../../../../services/api/api_services.dart';
// import '../../../../services/repository/common_repository/common_repository.dart';
// import '../../../../services/sockets/app_socket_all_operation.dart';
// import '../../../../utils/app_log/app_log.dart';
// import '../../../../utils/app_log/error_log.dart';
// import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
//
// ///===========================================
//
//
// enum BookingStatus{upcoming, completed}
//
// class BookingListController extends GetxController {
//
//   BookingStatus bookingStatus = BookingStatus.upcoming;
//
//   ScrollController scrollController = ScrollController();
//   CommonRepository commonRepository = CommonRepository();
//   AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;
//
//
//
//   RxList<BookingModel> bookingList = <BookingModel>[].obs;
//
//   RxBool isLoading = true.obs;
//   RxBool isPagination = false.obs;
//   int currentPage = 1;
//   bool isLast = false;
//
//
//
//   Future<void> onDataLoad()async{
//     try{
//       if(isLast){
//         isLoading.value = false;
//         isPagination.value = false;
//         return;
//       }
//
//       var response = await commonRepository.getBookingList(
//           page: currentPage, bookingStatus:bookingStatus );
//       if(response.isEmpty){
//         isLast = true;
//       }else{
//         bookingList.addAll(response);
//
//       }
//       currentPage++;
//     }catch(e){
//       errorLog(e);
//     }
//     isLoading.value = false;
//     isPagination.value = false;
//   }
//
//   void paginationData(){
//     try{
//       scrollController.addListener(() {
//         if(scrollController.hasClients){
//           if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
//             if(isPagination.value == false){
//               isPagination.value = true;
//               onDataLoad();
//             }
//
//           }
//         }
//       },);
//     }catch(e){
//       errorLog(e);
//     }
//   }
//
//   var loadingBookingId;
//   Future<void> bookingSuccess({required String bookingId}) async {
//     loadingBookingId = bookingId;
//     update();
//
//     try {
//       final response = await ApiService.patchApi(
//         ApiUrls.bookingSuccessUrl(bookingId: bookingId),
//       );
//
//       if (response.statusCode == 200) {
//         AppSnackBar.success(response.message);
//       }else{
//         AppSnackBar.error(response.message);
//
//       }
//     } catch (e) {
//       AppSnackBar.error("Error completing booking: ${e.toString()}");
//     } finally {
//       loadingBookingId = null;
//       update();
//     }
//   }
//
//
//     void onBookingStatusChange(int index){
//     bookingStatus = BookingStatus.values.elementAt(index);
//   }
//
//
//   void bookingListSocketHandler(dynamic message) {
//     try {
//
//       bookingList.insert(
//           0, BookingModel.fromJson(message));
//       bookingList.refresh();
//       appLog('rahat');
//     } catch (e) {
//       errorLog("chatMessageSocketHandler $e");
//     }
//   }
//
//
//
//
//   Future<void> onAppInitialDataLoad()async{
//     try{
//       isLoading.value = true;
//       await onDataLoad();
//       paginationData();
//
//       appSocketAllOperation.readEvent(
//           event: "booking::$loadingBookingId",
//           handler: (data) {
//
//             bookingListSocketHandler(data);
//
//             appLog('👌👌👌👌new booking==>>> ${data}  ');
//
//
//
//
//           });
//
//
//     }catch(e){
//
//       errorLog(e);
//     }
//     isLoading.value = false;
//   }
//
//   @override
//   void onInit() {
//     onAppInitialDataLoad();
//     super.onInit();
//   }
// }