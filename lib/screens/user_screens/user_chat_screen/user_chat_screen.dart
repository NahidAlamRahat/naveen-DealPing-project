import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../business_screens/business_chat_screen/business_chat_screen.dart';
import 'controller/user_chate_controller.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserChatController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: 'Mirchi Dance',

///PopupMenuButton
/*
        action: PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 1) {}
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text("Report", style: TextStyle(fontSize: 14, color: AppColors.grey300)),
            ),
            const PopupMenuDivider(height: 0.2),
            const PopupMenuItem(
              value: 1,
              child: Text("Delete Chat", style: TextStyle(fontSize: 14, color: AppColors.grey300)),
            ),
          ],
          color: AppColors.white,
          elevation: 2,
        ),
*/


      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return ChatMessage(
                  text: message['text'] as String?,
                  image: message['image'] as File?,
                  isSent: message['isSent'] as bool,
                  time: message['time'] as String,
                  showButton: message['button'] == true,
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
