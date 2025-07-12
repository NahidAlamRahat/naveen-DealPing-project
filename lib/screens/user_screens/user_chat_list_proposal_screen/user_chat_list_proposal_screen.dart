/*
import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_image_path.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserChatListProposalScreen extends StatefulWidget {
  const UserChatListProposalScreen({super.key});

  @override
  _UserChatListProposalScreenState createState() =>
      _UserChatListProposalScreenState();
}

class _UserChatListProposalScreenState
    extends State<UserChatListProposalScreen> {
  List<Map<String, dynamic>> messages = List.generate(
      5,
      (index) => {
            "name": "Mirchi Dance 007",
            "message": "Hello! Thanks for reaching out. Yes....",
            "time": "01:42",
            "unread": 2,
            "image": AppImagePath.bookingsImage,
          });

  @override
  Widget build(BuildContext context) {
    final String chatItem = Get.arguments as String;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(text: chatItem),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SpaceWidget(spaceHeight: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Search Your message",
                hintStyle: const TextStyle(
                  color: AppColors.grey200,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey300,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.grey300),
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            ...List.generate(messages.length, (index) {
              var msg = messages[index];

              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.userChatScreen);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ImageWidget(
                              imagePath: msg['image'],
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SpaceWidget(spaceWidth: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: msg['name'],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.green500,
                              ),
                              TextWidget(
                                text: msg['message'],
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.grey700,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (msg['unread'] > 0)
                            CircleAvatar(
                              radius: 9,
                              backgroundColor: AppColors.redisPink,
                              child: TextWidget(
                                text: msg['unread'].toString(),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.white,
                              ),
                            ),
                          const SpaceWidget(spaceHeight: 2),
                          TextWidget(
                            text: msg['time'],
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontColor: AppColors.grey300,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SpaceWidget(spaceHeight: 12),
            ButtonWidget(
              onPressed: () {},
              label: AppStrings.viewMore,
              buttonHeight: 36,
              buttonWidth: 100,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
*/

///================================================

import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/utils/app_size.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller.dart';

class UserChatListProposalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatController _chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppbarWidget(text: _chatController.request.value?.message ?? ''),

      backgroundColor: AppColors.white,
      // appBar: AppbarWidget(text: "chatItem"),

      body: GetBuilder<ChatController>(
        init: ChatController(),
        // Ensure the controller is initialized
        builder: (controller) {
          // Display a loading indicator while data is loading
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display an error message if any
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          // If chatList is empty, show a message
          if (controller.chatList.isEmpty) {
            return const Center(child: Text('No chats available.'));
          }

          // Display the chat list
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SpaceWidget(spaceHeight: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search Your message",
                    hintStyle: const TextStyle(
                      color: AppColors.grey200,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.grey300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey300),
                    ),
                  ),
                ),
                const SpaceWidget(spaceHeight: 16),
                // Using List.generate to display chat data
                Column(
                  children: List.generate(controller.chatList.length, (index) {
                    var chat = controller.chatList[index];

                    return InkWell(
                      onTap: () {
                        // Navigate to the chat screen
                        Get.toNamed(AppRoutes.userChatScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: NetworkImageWidget(
                                      height: AppSize.height(value: 40),
                                      width: AppSize.width(value: 40),
                                      networkImageUrl: chat.participantProfile,
                                    )),
                                const SpaceWidget(spaceWidth: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: chat.participantBusinessName,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontColor: AppColors.green500,
                                    ),
                                    TextWidget(
                                      text: chat.latestMessage,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontColor: AppColors.grey700,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (chat.unreadMessageCount > 0)
                                  CircleAvatar(
                                    radius: 9,
                                    backgroundColor: AppColors.redisPink,
                                    child: TextWidget(
                                      text: chat.unreadMessageCount.toString(),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontColor: AppColors.white,
                                    ),
                                  ),
                                const SpaceWidget(spaceHeight: 2),
                                TextWidget(
                                  text: (DateTime.tryParse(
                                     chat.latestMessageTime) ??
                                    DateTime.now())
                                      .time,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontColor: AppColors.grey300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SpaceWidget(spaceHeight: 12),
                ButtonWidget(
                  onPressed: () {},
                  label: AppStrings.viewMore,
                  buttonHeight: 36,
                  buttonWidth: 100,
                  fontSize: 12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
