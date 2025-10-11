import 'package:deal_ping/models/notification_model.dart';
import 'package:deal_ping/utils/app_log/error_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../services/sockets/app_socket_all_operation.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../../utils/app_log/app_log.dart';

///==================================

class NotificationController extends GetxController {
  ScrollController scrollController = ScrollController();
  CommonRepository commonRepository = CommonRepository();
  AppSocketAllOperation appSocketAllOperation = AppSocketAllOperation.instance;

  // final UserNotificationApiCallerController apiCallerController =
  //     Get.put(UserNotificationApiCallerController());

  RxList<NotificationModel> notificationsList = <NotificationModel>[].obs;

  // var searchQuery = ''.obs;
  // var filterType = 'Weekly'.obs;
  // var isViewMore = true.obs; // To manage view state
  // final filterOptions = ['Weekly', 'Monthly'];


  int get unreadCount => notificationsList.where((n) => n.isRead == false).length;

  void onMarkAllRead(int value) async {
    if (value == 1) {
      isLoading.value = true; // Start loading
      update(); // Show loading on UI immediately

      try {
        await commonRepository.readNotification(); // API Call

        // Update notifications as read manually if needed
        notificationsList.value = notificationsList.map((notification) {
          notification.isRead = true;
          return notification;
        }).toList();

        notificationsList.refresh(); // Update Obx list
      } catch (e) {
        errorLog("Mark all read error: $e");
      }

      isLoading.value = false; // End loading
      update(); // Refresh UI after operation
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
  notificationsList.addAll(response);

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




  void notificationSocketHandler(dynamic data) {
    try {
      final newNotification = NotificationModel.fromJson(data);

      if (newNotification.id.isEmpty || newNotification.body.isEmpty) return;

      notificationsList.insert(0, newNotification);
      notificationsList.refresh();
    } catch (e) {
      errorLog("notificationSocketHandler $e");
    }
  }




  Future<void> onAppInitialDataLoad()async{
    try{
      isLoading.value = true;
await onDataLoad();
      paginationData();

      appSocketAllOperation.readEvent(
          event: "notification::${LocalStorage.userId}",
          handler: (data) {

            notificationSocketHandler(data);
            
            appLog('👌👌👌👌new notification==>>> ${data}  ');


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
