import 'dart:io';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/chat_message_responce_model.dart';
import '../../../../services/repository/common_repository/common_repository.dart';
import '../../../../utils/app_log/error_log.dart';

class UserChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> images = [];
  String chatId = '686c9e47cb13e5e76eba962e';

  CommonRepository commonRepository = CommonRepository();

  RxList<ChatMessageResponseModel> chatMessages =
      <ChatMessageResponseModel>[].obs;

  int currentPage = 1;
  RxBool isLoading = false.obs;

  Future<void> fetchChatMessages() async {
    try {
      isLoading.value = true;
      final data = await commonRepository.getChatMessage(currentPage);

      if (data.isNotEmpty) {
        chatMessages.addAll( data); // <-- নতুন ডাটা লিস্টের শুরুতে যোগ করুন
        currentPage++;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorLog(e);
    }
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty && images.isEmpty) return;

    var response = await commonRepository.sendMessage(
      message: messageController.text.trim(),
      chatId: chatId,
      imageUrl: images,
    );

    if (response != null) {
      chatMessages.add(response); // নতুন মেসেজ লিস্টের শেষে যোগ হবে
      messageController.clear();
    }
  }
  // // Send new message and add it to the bottom of the list
  // Future<void> sendMessage() async {
  //   if (messageController.text.trim().isEmpty && images.isEmpty) return;
  //
  //   var response = await commonRepository.sendMessage(
  //       message: messageController.text.trim(),
  //       chatId: chatId,
  //       imageUrl: images);
  //
  //   images.clear();
  //   if (response != null) {
  //     chatMessages.add(response);
  //     messageController.clear();
  //     update();
  //   }
  // }

  // Pick images for the message
  Future<void> pickImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    images.addAll(pickedImages);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    appLog('onInit called');
    fetchChatMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
