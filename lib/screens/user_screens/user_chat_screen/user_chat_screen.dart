
import 'dart:io';

import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../business_screens/business_chat_screen/business_chat_screen.dart';
import '../../common_widget/chat_message_widget.dart';
import 'controller/user_chate_controller.dart';


class UserChatScreen extends StatelessWidget{
  const UserChatScreen({super.key,});

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: UserChatController(),
        builder: (controller) {
          return Scaffold(

            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(AppSize.width(value: 8)).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.width(value: 10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //  Image preview chips
                  Obx((){
                    if (controller.images.isEmpty) return const SizedBox();
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(controller.images.length, (index) {
                          final image = controller.images[index];
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
                                      controller.images.removeAt(index);
                                      controller.update();
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
                  },),

                  const SizedBox(height: 8),

                  // Message Row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image, color: Colors.green, size: 32),
                        onPressed: controller.pickImage,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
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
                        child:
                        GetBuilder<UserChatController>(builder: (controllers) {
                          return Visibility(
                            visible: controllers.isMessageSent == false,
                            replacement:
                            const Center(child: CircularProgressIndicator()),
                            child: FloatingActionButton(
                              onPressed: controller.sendMessage,
                              backgroundColor: AppColors.green500,
                              child: const Icon(Icons.send_rounded, color: AppColors.white),
                            ),
                          );
                        }),

                      ),
                    ],
                  ),
                ],
              ),
            ),



            ///AppBar
            backgroundColor: AppColors.white,
            appBar: AppbarWidget(
              textWidget: Obx(() {
                final index = controller.selectedChatIndex.value;
                final name = controller.chatMessages.isNotEmpty &&
                    index < controller.chatMessages.length
                    ? controller.chatMessages[index].sender?.name
                    : null;

                if (name == null) {
                  return const Text('Loading...');
                } else if (name.trim().isEmpty) {
                  return const Text('Unknown');
                } else {
                  return Text(name);
                }
              }),
            ),



            body: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator()); // Initial loading
              }

              if (controller.chatMessages.isEmpty) {
                return const Center(child: Text('No messages available')); // No messages
              }

              return ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                physics: const ClampingScrollPhysics(),
                itemCount: controller.chatMessages.length +
                    (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.chatMessages.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(), // pagination loading
                    );
                  }

                  final message = controller.chatMessages[index];

                  return
                    ChatMessage(
                      chatId: controller.chatId,
                      text: message.message,
                      isSent: message.sender?.id == LocalStorage.userId,
                      time: (DateTime.tryParse(message.createdAt.toString()) ??
                          DateTime.now())
                          .time,
                      image: message.images,
                      showButton: message.type ?? 'text',
                      message: controller.chatMessages[index],

                    );

                },
              );
            }),

          );
        }
    );
  }
}
