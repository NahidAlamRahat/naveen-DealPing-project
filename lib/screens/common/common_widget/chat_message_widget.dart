import 'package:deal_ping/screens/user_screens/user_chat_list_proposal_screen/controller.dart';
import 'package:deal_ping/services/repository/common_repository/common_repository.dart';
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_image_path.dart';
import '../../../constants/app_strings.dart';
import '../../../models/chat_message_responce_model.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../user_screens/user_chat_list_screen/controller/chat_list_api_caller.dart';
import '../../user_screens/user_chat_screen/controller/user_chate_controller.dart';
import '../../user_screens/user_chat_screen/widget/image_view.dart';
import '../../user_screens/user_chat_screen/widget/network_image_grid.dart';

class ChatMessage extends StatelessWidget {

  final ChatMessageResponseModel? message;
  final String? text;
  final List<String> ? image;
  final bool isSent;
  final String time;
  final String showButton;
  final String? chatId;

  const ChatMessage({

    super.key,
    this.chatId,
    this.text,
    this.image,
    this.message,
    required this.isSent,
    required this.time,
    this.showButton = 'text',
  }


      );

  @override
  Widget build(BuildContext context) {

    CommonRepository commonRepository=Get.put(CommonRepository());


    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,

        children: [
          // মেসেজ বক্স

          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(1.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70,
            ),
            decoration: (image == null || image!.isEmpty)
                ? BoxDecoration(
              color: (text != null && text!.isNotEmpty)
                  ? (isSent ? AppColors.green500 : AppColors.green50)
                  : null,
              borderRadius: BorderRadius.circular(8),
            )
                : null,


            child: Column(
              crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,

              children: [

                if (image != null && image!.isNotEmpty)
                  Column(

                    children: [
                      NetworkImageGrid(
                        images: image,
                        onTap: (index) {
                          final imagePath = image?[index];
                          Get.to(() => FullScreenImageView(imagePath: imagePath ??''));
                        },

                      ),

                      if (text != null && text!.isNotEmpty)
                        const SizedBox(height: 8),
                    ],
                  ),


                if (text != null && text!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSent ? AppColors.green500 : AppColors.green50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextWidget(
                      text: text!,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: isSent ? AppColors.white : AppColors.grey700,
                      textAlignment: TextAlign.start,
                    ),
                  ),




                // বুকিং UI
                if (showButton=='offer') ...[
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
                                  TextWidget(
                                    text: message?.offerTitle?.toString() ?? '',

                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                  ),

                                  Row(
                                    children: List.generate(5, (index) {
                                      final rating = message?.sender?.rating ?? 0.0;

                                      if (index < rating.floor()) {
                                        return const Icon(Icons.star, color: AppColors.yellow, size: 12); // Full star
                                      } else if (index < rating && rating - index >= 0.5) {
                                        return const Icon(Icons.star_half, color: AppColors.yellow, size: 12); // Half star
                                      } else {
                                        return const Icon(Icons.star_border, color: AppColors.yellow, size: 12); // Empty star
                                      }
                                    }),
                                  ),

                                  TextWidget(

                                    text: message?.sender?.address?.toString() ?? '',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontColor: AppColors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  ///miles
                                  const Row(
                                    children: [
                                      IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "0 miles",
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

                        if (LocalStorage.myRole == 'user') ...[
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              ElevatedButton(
                                      onPressed: () async {
                                        /// get message by chat id api call

                                        // await commonRepository.messageEnable(chatId: chatId.toString()); // ডেটা শেষ হলে পরের স্ক্রিনে যাওয়া
                                        Get.toNamed(AppRoutes.userBookingSummaryScreen, arguments: message);
                                          appLog("👌👌👌👌d${message!.id}");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text('Accept'),
                                    ),



                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  commonRepository.messageEnable(chatId: chatId ?? '');
                                  appLog('messsage button ===>> chatId ==>> $chatId');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('message'),
                              ),
                            ],
                          )
                        ],

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
