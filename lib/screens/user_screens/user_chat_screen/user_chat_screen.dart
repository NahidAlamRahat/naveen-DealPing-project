import 'dart:io';

import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../common/common_widget/chat_message_widget.dart';
import 'controller/user_chate_controller.dart';

class UserChatScreen extends StatelessWidget {
  UserChatScreen({super.key});

  // ✅ Single instance ব্যবহার করুন
  final UserChatController userChatController = Get.put(UserChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 8)).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.width(value: 10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image preview chips
            Obx(() {
              if (userChatController.images.isEmpty) return const SizedBox();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(userChatController.images.length, (index) {
                    final image = userChatController.images[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(image.path),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                userChatController.images.removeAt(index);
                                userChatController.update();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, size: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              );
            }),

            const SizedBox(height: 8),

            // Message Row
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.green, size: 32),
                  onPressed: userChatController.pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: userChatController.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(
                        color: AppColors.grey300,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.grey300),
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: GetBuilder<UserChatController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.isMessageSent,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: FloatingActionButton(
                          onPressed: controller.sendMessage,
                          backgroundColor: AppColors.green500,
                          child: const Icon(Icons.send_rounded, color: AppColors.white),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),

      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        textWidget: Obx(() {
          // ✅ AppBar এর জন্য better logic
          if (userChatController.chatMessagesList.isEmpty) {
            return const Text('Loading...');
          }

          // Get the other person's name from any message
          final otherPersonMessage = userChatController.chatMessagesList.firstWhere(
                (msg) => msg.sender?.id != LocalStorage.userId,
            orElse: () => userChatController.chatMessagesList.first,
          );

          final name = otherPersonMessage.sender?.name ?? 'Unknown';
          return Text(name);
        }),
      ),

      body: Obx(() {
        if (userChatController.isLoading.value && userChatController.chatMessagesList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userChatController.chatMessagesList.isEmpty && !userChatController.isLoading.value) {
          return const Center(child: Text('No messages available'));
        }

        return Column(
          children: [
            // ✅ Pagination loading indicator at top
            if (userChatController.isPagination.value)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),

            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: userChatController.scrollController,
                padding: const EdgeInsets.all(16),
                physics: const ClampingScrollPhysics(),
                itemCount: userChatController.chatMessagesList.length,
                itemBuilder: (context, index) {
                  final message = userChatController.chatMessagesList[index];

                  return ChatMessage(
                    requestId: userChatController.requestId,
                    chatId: userChatController.chatId,
                    text: message.message,
                    isSent: message.sender?.id == LocalStorage.userId,
                    time: (DateTime.tryParse(message.createdAt.toString()) ?? DateTime.now()).time,
                    image: message.images,
                    showButton: message.type ?? 'text',
                    chatMessageResponseModelList: message,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}