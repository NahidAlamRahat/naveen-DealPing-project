import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_icons_path.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          "Hi! I'd love to book a table for 4 tonight. Do you have availability?",
      'isSent': true,
      'time': '09:41',
    },
    {
      'text':
          "Hello! Thanks for reaching out! Let me check availability for you.\n\nWe have a table for 4 available at 9:00 PM tonight. Plus, we’re offering 20% off your first bottle of wine! 🍷 Would you like to confirm the booking?",
      'isSent': false,
      'time': '16:38',
    },
    {
      'text':
          "Yes, please! Can we also get a bottle of wine with the discount?",
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
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text,
          'isSent': true,
          'time': '16:38', // You can use DateTime.now() for real-time
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: 'Mirchi Dance',
        action: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Handle more options
          },
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
                  text: message['text'],
                  isSent: message['isSent'],
                  time: message['time'],
                  showButton: message['button'] == true,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSent;
  final String time;
  final bool showButton;

  const ChatMessage({
    super.key,
    required this.text,
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
                TextWidget(
                  text: text,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: isSent ? AppColors.white : AppColors.grey700,
                  textAlignment: TextAlign.start,
                ),
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
                            // Placeholder for the image (you can add an actual image here)
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                    text: 'Mirchi Dance Bar',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                  ),
                                  // const SpaceWidget(spaceHeight: 2),
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
                                  Row(
                                    children: [
                                      const IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
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
                        ElevatedButton(
                          onPressed: () {
                            // Handle booking confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Table booked successfully!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Book Your Table',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
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
