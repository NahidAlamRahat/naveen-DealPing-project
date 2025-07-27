import 'dart:io';

import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../business_screens/business_chat_screen/business_chat_screen.dart';
import 'controller/user_chate_controller.dart';
class UserChatScreen extends StatefulWidget {
  final String? chatId;
   UserChatScreen({super.key} ):chatId = Get.arguments ['chatId'];

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {


  final controller = Get.put(UserChatController());

  @override
  void initState() {
    controller.setChatId(widget.chatId);controller.setChatId(widget.chatId);
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(


      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(AppSize.width(value: 8) ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.width(value: 10)
        ),
        child: Row(
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
                      color: AppColors.grey300, fontWeight: FontWeight.w400, fontSize: 14),
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
              child: FloatingActionButton(
                onPressed: controller.sendMessage,
                backgroundColor: AppColors.green500,
                child: const Icon(Icons.send_rounded, color: AppColors.white),
              ),
            ),
          ]
        ),
      ),

      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        textWidget: Obx(
          () => Text('${controller.chatMessages[0].sender?.name}'),
        ),
      ),
      body:  Obx(() {
        if (controller.chatMessages.isEmpty) {
          return const Center(child: Text('No messages available'));
        }

        return ListView.builder(
          reverse: true,
          controller: controller.scrollController,
          padding: const EdgeInsets.all(16),
          physics: const ClampingScrollPhysics(),
          itemCount: controller.chatMessages.length + (controller.isLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.chatMessages.length) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            }

            final message = controller.chatMessages[index];



            return ChatMessage(
              text: message.message ?? '',
              time: (DateTime.tryParse(
            message.createdAt.toString()) ??
            DateTime.now())
                .time,
              isSent: message.sender?.id == LocalStorage.userId,
            );

          },
        );
      }),
    );
  }
}


