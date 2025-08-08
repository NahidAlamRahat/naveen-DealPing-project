
import 'package:deal_ping/services/api/api_services.dart';
import 'package:deal_ping/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import '../../../../constants/api_urls.dart';
import '../../../../models/request_list_model.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/app_log.dart';
import '../../../../utils/app_log/error_log.dart';
import '../../user_chat_list_proposal_screen/controller.dart';

class RequestListController extends GetxController {
  ScrollController scrollController = ScrollController();
  CommonRepository commonRepository = CommonRepository();

  List<RequestModel> _originalRequestList = [];

  RxList<RequestModel> requestModelList = <RequestModel>[].obs;

  RxBool isLoading = true.obs;
  RxBool isPagination = false.obs;
  int currentPage = 1;
  bool isLast = false;

  Future<void> onDataLoad() async {
    try {
      if (isLast) return;

      var responses = await commonRepository.getRequestList(currentPage);


      if (responses.isEmpty) {
        isLast = true;
      } else {
        _originalRequestList.addAll(responses);
        requestModelList.addAll(responses);
        currentPage++;
      }

    } catch (e) {
      errorLog(e);
    } finally {
      isLoading.value = false;
      isPagination.value = false;
    }
  }



  void filterList(String query) {
    print('Query: $query');
    if (query.isEmpty) {
      print('❤️❤️Resetting full list');
      requestModelList.value = _originalRequestList;
    } else {
      final filtered = _originalRequestList.where((request) {
        print('Checking: ${request.message}');
        return (request.message ?? '')
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      print('Filtered count: ${filtered.length}');
      requestModelList.value = filtered;
    }
  }



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

    _originalRequestList.clear();
    requestModelList.clear();
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


