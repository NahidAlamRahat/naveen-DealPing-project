import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // send message
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {
      'text': "Hi! I'd love to book a table for 4 tonight. Do you have availability?",
      'isSent': true,
      'time': '09:41',
    },


    //receiver
    {
      'text':
      "=reaching out! Let me check availability for you.\n\nWe have a table for 4 available at 9:00 PM tonight. Plus, we’re offering 20% off your first bottle of wine! 🍷 Would you like to confirm the booking?",
      'isSent': false,
      'time': '16:38',
    },

    {
      'text': "Yes, please! Can we also get a bottle of wine with the discount?",
      'isSent': true,
      'time': '16:38',
    },
    {
      'text': "Of Course.\n\nIs there anything else you want to add?",
      'isSent': false,
      'time': '16:38',
    },
    {
      'text': "No. Thank you",
      'isSent': true,
      'time': '16:38',
    },
    {
      'text':
      "Your table for 4 at 12:30 PM is pending.\n\nWe’re holding the spot for you! To confirm your reservation, please click below.",
      'isSent': false,
      'time': '16:38',
      'button': true,
    },
    {
      'text':
      "YOU’RE ALL SET! We’ll see you at 9:00 PM tonight. 🎵 Enjoy the music and drinks, and don’t forget to show this message to claim your 20% off wine! 🍷\n\nIf anything changes, feel free to message us!",
      'isSent': false,
      'time': '16:38',
    },
  ].obs;

  void sendMessage({File? image}) {
    if (image != null || messageController.text.isNotEmpty) {
      messages.add({
        if (image != null) 'image': image,
        if (messageController.text.isNotEmpty) 'text': messageController.text,
        'isSent': true,
        'time': '16:38', // Ideally use DateTime.now()
      });
      messageController.clear();
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      sendMessage(image: File(image.path));
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
