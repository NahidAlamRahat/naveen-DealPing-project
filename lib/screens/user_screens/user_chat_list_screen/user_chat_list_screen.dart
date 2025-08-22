import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_strings.dart';
import '../../../models/request_list_model.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../common/common_widget/search_bar_widget.dart';
import 'controller/chat_list_api_caller.dart';


class UserChatListScreen extends StatelessWidget {
  final searchController = TextEditingController();

  UserChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestListController controller = Get.put(RequestListController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceWidget(spaceHeight: 20),

          // Search Field
          SearchBarWidget(
            controller: searchController,
            onChanged: (value) {
              controller.filterList(value);
            },
          ),

          // Header Row
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: AppStrings.chatList,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                  textAlignment: TextAlign.start,
                ),
              ],
            ),
          ),

          const SpaceWidget(spaceHeight: 6),

          // List Section
          Expanded(
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: () async {
                await controller.refreshRequestList();
              },
              child: controller.requestModelList.isEmpty
                  ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text("No requests available."),
                    ),
                  ),
                ],
              )
                  : ListView.builder(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.requestModelList.length +
                    (controller.isPagination.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.requestModelList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  }

                  RequestModel request =
                  controller.requestModelList[index];
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey50, width: 1),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.userChatListProposalScreen,
                          arguments: request,
                        );
                      },
                      title: TextWidget(
                        text: request.message,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.grey300,
                        textAlignment: TextAlign.start,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      )),
    );
  }
}
