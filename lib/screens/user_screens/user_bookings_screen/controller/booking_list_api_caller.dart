


import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../constants/api_urls.dart';
import '../../../../models/booking_list_model.dart';
import '../../../../services/api/api_services.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../utils/app_log/error_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

///===========================================


enum BookingStatus{upcoming, completed}

class BookingListController extends GetxController {

  BookingStatus bookingStatus = BookingStatus.upcoming;

  ScrollController scrollController = ScrollController();
  CommonRepository commonRepository = CommonRepository();
  AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;

  var loadingBookingId;



  RxList<BookingModel> bookingList = <BookingModel>[].obs;

  RxBool isLoading = true.obs;
  RxBool isPagination = false.obs;
  int currentPage = 1;
  bool isLast = false;


/*
  void onDataLoad() async {
    try {
      if (isLast) {
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

      var response = await commonRepository.getBookingList(
        page: currentPage,
        bookingStatus: bookingStatus,
      );

      if (response.isEmpty) {
        isLast = true;
      } else {
        bookingList.addAll(response);
        currentPage++;
      }
    } catch (e) {
      errorLog(e);
    } finally {
      // এইখানে loading & pagination false করবেন
      isLoading.value = false;
      isPagination.value = false;
    }
  }
*/


  Future<void> onDataLoad() async {
    try {
      if (isLast) {
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

      var response = await commonRepository.getBookingList(
        page: currentPage,
        bookingStatus: bookingStatus,
      );

      if (response.isEmpty) {
        isLast = true;
      } else {
        bookingList.addAll(response);
        currentPage++;
      }
    } catch (e) {
      errorLog(e);
    } finally {
      isLoading.value = false;
      isPagination.value = false;
    }
  }



  Future<void> refreshBookingList() async {
    try {
      currentPage = 1;
      isLast = false;
      bookingList.clear();
      isLoading.value = true;
      await onDataLoad();
    } catch (e) {
      errorLog(e);
    }
  }


  void paginationData() {
    try {
      scrollController.addListener(() {
        if (scrollController.hasClients) {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100) {
            if (!isPagination.value && !isLoading.value && !isLast) {
              isPagination.value = true;
              onDataLoad();
            }
          }
        }
      });
    } catch (e) {
      errorLog(e);
    }
  }

  void onBookingStatusChange(int index) {
    bookingStatus = BookingStatus.values.elementAt(index);

    currentPage = 1;
    isLast = false;
    bookingList.clear();

    isLoading.value = true;
    onDataLoad();
  }


  Future<void> bookingSuccess({required String bookingRequestId}) async {
    loadingBookingId = bookingRequestId;
    update();

    try {
      final response = await ApiService.patchApi(
        ApiUrls.bookingSuccessUrl(bookingId: bookingRequestId),
      );

      if (response.statusCode == 200) {
        AppSnackBar.success(response.message);
      }else{
        AppSnackBar.error(response.message);

      }
    } catch (e) {
      AppSnackBar.error("Error completing booking: ${e.toString()}");
    } finally {
      loadingBookingId = null;
      update();
    }
  }


  // void onBookingStatusChange(int index) {
  //   bookingStatus = BookingStatus.values.elementAt(index);
  //
  //   // ✅ reset pagination state
  //   currentPage = 1;
  //   isLast = false;
  //   bookingList.clear();
  //   isLoading.value = true;
  //
  //   onDataLoad();
  // }


  void bookingListSocketHandler(dynamic message) {
    try {

      bookingList.insert(
          0, BookingModel.fromJson(message));
      bookingList.refresh();
      isLoading.value = false;

      appLog('rahat');
    } catch (e) {
      errorLog("chatMessageSocketHandler $e");
    }
  }




  Future<void> onAppInitialDataLoad()async{
    try{
      isLoading.value = true;
      onDataLoad();
      paginationData();

      appSocketAllOperation.readEvent(
          event: "booking::${LocalStorage.userId}",
          handler: (data) {

            bookingListSocketHandler(data);

            appLog('👌👌👌👌new booking==>>> ${data}  ');


          });


    }catch(e){

      errorLog(e);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    onAppInitialDataLoad();
    super.onInit();
  }
}