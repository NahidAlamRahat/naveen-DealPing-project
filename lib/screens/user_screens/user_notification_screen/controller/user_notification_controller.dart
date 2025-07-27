import 'package:deal_ping/models/notification_model.dart';
import 'package:deal_ping/utils/app_log/error_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../services/repository/common_repository/common_repository.dart';

///==================================

class UserNotificationController extends GetxController {
  ScrollController scrollController = ScrollController();
  CommonRepository commonRepository = CommonRepository();
  // final UserNotificationApiCallerController apiCallerController =
  //     Get.put(UserNotificationApiCallerController());

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  // var searchQuery = ''.obs;
  // var filterType = 'Weekly'.obs;
  // var isViewMore = true.obs; // To manage view state
  // final filterOptions = ['Weekly', 'Monthly'];


  int get unreadCount => notifications.where((n) => n.isRead == false).length;

  void onMarkAllRead(int value) {
    if (value == 1) {
      // Get.snackbar('Notifications', 'All marked as read');
      commonRepository.readNotification();
    }
  }

  // void onViewMore() {
  //   // Logic for loading more notifications
  //   Get.snackbar('View More', 'Loading more notifications...');
  // }

  RxBool isLoading = true.obs;
  RxBool isPagination = false.obs;
  int currentPage = 1;
  bool isLast = false;



  Future<void> onDataLoad()async{
    try{
      if(isLast){
        isLoading.value = false;
        isPagination.value = false;
        return;
      }

    var response = await  commonRepository.getNotificationData(currentPage);
if(response.isEmpty){
  isLast = true;
}else{
  notifications.addAll(response);

}
      currentPage++;
    }catch(e){
      errorLog(e);
    }
    isLoading.value = false;
    isPagination.value = false;
  }

 void paginationData(){
    try{
      scrollController.addListener(() {
        if(scrollController.hasClients){
          if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
            if(isPagination.value == false){
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

  @override
  void onInit() {
    onAppInitialDataLoad();
    super.onInit();
  }
}
