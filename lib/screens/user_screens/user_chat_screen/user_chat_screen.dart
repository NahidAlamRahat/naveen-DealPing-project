import 'dart:io';

import 'package:deal_ping/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../business_screens/business_chat_screen/business_chat_screen.dart';
import 'controller/user_chate_controller.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {

  ScrollController _scrollController = ScrollController();
  final controller = Get.put(UserChatController());

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.minScrollExtent - 100) {
        controller.fetchChatMessages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: 'Mirchi Dance',
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.chatMessages.isEmpty) {
                return const Center(child: Text('No messages available'));
              }

              return ListView.builder(
                controller: _scrollController,
                // reverse: true, // <-- এখানে reverse: true যোগ করুন
                padding: const EdgeInsets.all(16),
                itemCount: controller.chatMessages.length + (controller.isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.chatMessages.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const SizedBox(),
                    );
                  }

                  // Reverse ইনডেক্সিং (পুরানো মেসেজ উপরে, নতুন মেসেজ নিচে)
                  final reversedIndex = controller.chatMessages.length - 1 - index;
                  final message = controller.chatMessages[reversedIndex];

                  return ChatMessage(
                    text: message.message ?? '',
                    time: message.createdAt ?? '',
                    isSent: message.sender?.id == '686a5af0f2d6c20e53a903cf',
                  );
                },
              );
            }),
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
