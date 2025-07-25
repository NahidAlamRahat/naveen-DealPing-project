import 'dart:io';

import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/icon_text_button/icon_text_button.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_icons_path.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class BusinessChatScreen extends StatefulWidget {
  const BusinessChatScreen({super.key});

  @override
  State<BusinessChatScreen> createState() => _BusinessChatScreenState();
}

class _BusinessChatScreenState extends State<BusinessChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          "Hi! I'd love to book a table for 4 tonight. Do you have availability?",
      'isSent': false,
      'time': '09:41',
    },
    {
      'text':
          "Hello! Thanks for reaching out! Let me check availability for you.\n\nWe have a table for 4 available at 9:00 PM tonight. Plus, we’re offering 20% off your first bottle of wine! 🍷 Would you like to confirm the booking?",
      'isSent': true,
      'time': '16:38',
    },
    {
      'text':
          "Yes, please! Can we also get a bottle of wine with the discount?",
      'isSent': false,
      'time': '16:38',
    },
    {
      'text': "Of Course.\n\nIs there anything else you want to add?",
      'isSent': true,
      'time': '16:38',
    },
    {
      'text': "No. Thank you",
      'isSent': false,
      'time': '16:38',
    },
    {
      'text':
          "Your table for 4 at 12:30 PM is pending.\n\nWe’re holding the spot for you! To confirm your reservation, please click below.",
      'isSent': true,
      'time': '16:38',
      'button': true,
    },
    {
      'text':
          "YOU’RE ALL SET! We’ll see you at 9:00 PM tonight. 🎵 Enjoy the music and drinks, and don’t forget to show this message to claim your 20% off wine! 🍷\n\nIf anything changes, feel free to message us!",
      'isSent': true,
      'time': '16:38',
    },
  ];

  void _sendMessage({File? image}) {
    if (image != null || _controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          if (image != null) 'image': image,
          if (_controller.text.isNotEmpty) 'text': _controller.text,
          'isSent': true,
          'time': '16:38', // You can use DateTime.now() for real-time
        });
        _controller.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _sendMessage(image: File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: 'Mirchi Dance',
        action: PopupMenuButton<int>(
          onSelected: (value) {
            if (value == 1) {
            } else if (value == 2) {
            } else if (value == 3) {
              showCustomPopup(
                context,
                [
                  const Center(
                    child: TextWidget(
                      text: AppStrings.bookingRequest,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.grey700,
                      textAlignment: TextAlign.center,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 11),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: 'Offer',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.grey300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.grey300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.grey300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.green500),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildOfferButtonsRow(),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconTextButton(
                      onTap: () {},
                      text: "Save",
                      textColor: AppColors.green500,
                      icon: Icons.save,
                      iconColor: AppColors.green500,
                      textWeight: FontWeight.w500,
                      fontSize: 12,
                      iconSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ButtonWidget(
                    onPressed: () {
                      Get.back();
                    },
                    label: AppStrings.sendRequest,
                    buttonWidth: double.infinity,
                    buttonHeight: 45,
                    fontSize: 14,
                  )
                ],
              );
            }
          },

          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Report",
                style: TextStyle(fontSize: 14, color: AppColors.grey300),
              ),
            ),
            const PopupMenuDivider(height: 0.5),
            const PopupMenuItem(
              value: 2,
              child: Text(
                "Delete Chat",
                style: TextStyle(fontSize: 14, color: AppColors.grey300),
              ),
            ),
            const PopupMenuDivider(height: 0.5),
            const PopupMenuItem(
              value: 3,
              child: Text(
                "Send Booking Request",
                style: TextStyle(fontSize: 14, color: AppColors.grey300),
              ),
            ),
          ],
          // offset: Offset(0, 100),
          color: AppColors.white,
          elevation: 2,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatMessage(
                  text: message['text'] as String?,
                  // Cast as nullable String
                  image: message['image'],
                  isSent: message['isSent'] as bool,
                  time: message['time'] as String,
                  showButton: message['button'] == true,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.green, size: 32),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(
                          color: AppColors.grey300,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
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
                    onPressed: () => _sendMessage(),
                    backgroundColor: AppColors.green500,
                    child: const Icon(
                      Icons.send_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferButton(int percentage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$percentage% offer',
            style: const TextStyle(fontSize: 10, color: AppColors.grey300),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.close,
            size: 16,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferButtonsRow() {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          10, // Number of steps from 5% to 50% (5, 10, ..., 50)
          (index) {
            int percentage = 5 * (index + 1); // 5%, 10%, ..., 50%
            return _buildOfferButton(percentage);
          },
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final String? image;
  final bool isSent;
  final String time;
  final bool showButton;

  const ChatMessage({
    super.key,
    this.text,
    this.image,
    required this.isSent,
    required this.time,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // মেসেজ বক্স
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(12.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isSent ? AppColors.green500 : AppColors.green50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ইমেজ থাকলে দেখাও
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      image as File,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                // ইমেজ ও টেক্সট দুটোই থাকলে স্পেস
                if (image != null && text != null)
                  const SizedBox(height: 8),

                // টেক্সট থাকলে দেখাও
                if (text != null)
                  TextWidget(
                    text: text!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: isSent ? AppColors.white : AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),

                // শো বাটন থাকলে বুকিং UI দেখাও
                if (showButton) ...[
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.green500,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: const ImageWidget(
                                height: 53,
                                width: 106,
                                imagePath: AppImagePath.bookingsImage,
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                    text: 'Mirchi Dance Bar',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                          (index) => const Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const TextWidget(
                                    text: "Dhanmondi, Dhaka",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontColor: AppColors.white,
                                  ),
                                  const Row(
                                    children: [
                                      IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "2.3 miles",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontColor: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ButtonWidget(
                          onPressed: () {},
                          backgroundColor: AppColors.white,
                          label: AppStrings.bookYourTable,
                          buttonHeight: 36,
                          buttonWidth: double.infinity,
                          fontSize: 12,
                          textColor: AppColors.grey700,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // টাইমস্ট্যাম্প
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
