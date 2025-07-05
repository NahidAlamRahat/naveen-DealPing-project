import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/chat_list_api_caller.dart';

class UserChatListScreen extends StatelessWidget {
  final searchController = TextEditingController();

  UserChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestListController>(
      init: RequestListController()..fetchRequestList(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceWidget(spaceHeight: 20),

              // Search Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: searchController,
                  style:
                      const TextStyle(color: AppColors.grey700, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Search Your Message",
                    hintStyle: const TextStyle(color: AppColors.grey200),
                    suffixIcon:
                        const Icon(Icons.search, color: AppColors.grey300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey300),
                    ),
                  ),
                ),
              ),

              // Header Row
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      text: AppStrings.chatList,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.grey700,
                      textAlignment: TextAlign.start,
                    ),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if (value == 1) {
                          // implement delete logic here
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded,
                                  color: AppColors.grey300),
                              SpaceWidget(spaceWidth: 10),
                              Text("Delete chat list",
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.grey300)),
                            ],
                          ),
                        ),
                      ],
                      color: AppColors.white,
                      elevation: 2,
                    ),
                  ],
                ),
              ),

              const SpaceWidget(spaceHeight: 6),

              // List Section
              Expanded(
                child: controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : controller.requestList.isEmpty
                        ? const Center(child: Text("No requests available."))
                        : RefreshIndicator(
                            onRefresh: () => controller.fetchRequestList(),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.requestList.length,
                              itemBuilder: (context, index) {
                                final request = controller.requestList[index];
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColors.grey50, width: 1),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.userChatListProposalScreen,
                                        arguments: request.message,
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
                                        color: Colors.green),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
