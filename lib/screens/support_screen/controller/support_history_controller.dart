import 'package:deal_ping/models/support_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../services/repository/common_repository/common_repository.dart';
import '../../../utils/app_log/error_log.dart';

class SupportHistoryController extends GetxController {
  ScrollController scrollController = ScrollController();
  CommonRepository commonRepository = CommonRepository();

  // List<SupportHistoryModel> _originalRequestList = [];

  RxList<SupportHistoryModel> supportHistoryModelList = <SupportHistoryModel>[].obs;

  RxBool isLoading = true.obs;
  RxBool isPagination = false.obs;
  int currentPage = 1;
  bool isLast = false;

  Future<void> onDataLoad() async {
    try {
      if (isLast) return;

      var responses = await commonRepository.getSupportHistoryData(currentPage);


      if (responses.isEmpty) {
        isLast = true;
      } else {
        // _originalRequestList.addAll(responses);
        supportHistoryModelList.addAll(responses);
        currentPage++;
      }

    } catch (e) {
      errorLog('Support history onDataLoad error==> $e ');
    } finally {
      isLoading.value = false;
      isPagination.value = false;
    }
  }



  // void filterList(String query) {
  //   print('Query: $query');
  //   if (query.isEmpty) {
  //     print('❤️❤️Resetting full list');
  //     requestModelList.value = _originalRequestList;
  //   } else {
  //     final filtered = _originalRequestList.where((request) {
  //       print('Checking: ${request.message}');
  //       return (request.message ?? '')
  //           .toLowerCase()
  //           .contains(query.toLowerCase());
  //     }).toList();
  //     print('Filtered count: ${filtered.length}');
  //     requestModelList.value = filtered;
  //   }
  // }



  void paginationData(){
    try{
      scrollController.addListener(() {
        if(scrollController.hasClients){
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            if (!isPagination.value && !isLast) {
              isPagination.value = true;
              onDataLoad();
            }
          }
        }
      },);
    }catch(e){
      errorLog(e);
    }
  }

  Future<void> onAppInitialDataLoad()async{
    try{
      isLoading.value = true;
      await onDataLoad();
      paginationData();
    }catch(e){

      errorLog(e);
    }
    isLoading.value = false;
  }


  Future<void> refreshRequestList() async {
    isLoading.value = true;

    // _originalRequestList.clear();
    supportHistoryModelList.clear();
    currentPage = 1;
    isLast = false;

    await onDataLoad();

    isLoading.value = false;
  }




  @override
  void onInit() {
    onAppInitialDataLoad();
    super.onInit();
  }
}
