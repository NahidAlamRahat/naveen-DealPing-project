import 'package:deal_ping/services/repository/common_repository/common_repository.dart';
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../models/chat_message_responce_model.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../user_screens/user_chat_screen/widget/image_view.dart';
import '../../user_screens/user_chat_screen/widget/network_image_grid.dart';

class ChatMessage extends StatelessWidget {

  final ChatMessageResponseModel? chatMessageResponseModelList;
  final String? text;
  final List<String> ? image;
  final bool isSent;
  final String time;
  final String showButton;
  final String? requestId;
  final String? chatId;


  const ChatMessage({

    super.key,
    this.requestId,

    this.text,
    this.image,
    this.chatMessageResponseModelList,
    required this.isSent,
    required this.time,
    this.showButton = 'text',
    this.chatId,
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
                      // Image + fallback icon
                      if (image != null && image!.isNotEmpty)
                        NetworkImageGrid(
                          images: image!,
                          onTap: (index) {
                            final imagePath = image![index];
                            if (imagePath.isNotEmpty) {
                              Get.to(() => FullScreenImageView(imagePath: imagePath));
                            }
                          },
                        )
                      else
                      // Fallback icon when no image
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey200, // background color for icon
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppColors.grey500,
                            size: 30,
                          ),
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
                if (showButton == 'offer') ...[
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
                            // Gift card icon instead of dev image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                height: 53,
                                width: 106,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.green,
                                  size: 32,
                                ),
                              ),
                            ),
                            const SpaceWidget(spaceWidth: 8),

                            // Text section wrapped with Expanded
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: chatMessageResponseModelList?.offerTitle ?? '',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.white,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),

                                  // Star rating
                                  Row(
                                    children: List.generate(5, (index) {
                                      final rating = chatMessageResponseModelList?.sender?.rating ?? 0.0;
                                      if (index < rating.floor()) {
                                        return const Icon(Icons.star, color: AppColors.yellow, size: 12);
                                      } else if (index < rating && rating - index >= 0.5) {
                                        return const Icon(Icons.star_half, color: AppColors.yellow, size: 12);
                                      } else {
                                        return const Icon(Icons.star_border, color: AppColors.yellow, size: 12);
                                      }
                                    }),
                                  ),

                                  // Address
                                  TextWidget(
                                    text: chatMessageResponseModelList?.sender?.address ?? '',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontColor: AppColors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // Miles
                                  const Row(
                                    children: [
                                      IconWidget(
                                        icon: AppIconsPath.locationIconWhite,
                                        width: 12,
                                        height: 12,
                                      ),
                                      SpaceWidget(spaceWidth: 4),
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

                        // Accept & Message buttons
                        if (LocalStorage.myRole == 'user') ...[
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.toNamed(
                                    AppRoutes.userBookingSummaryScreen,
                                    arguments: {
                                      "chatMessage": chatMessageResponseModelList,
                                      "requestId": requestId,
                                      "chatId": chatId,
                                    },
                                  );

                                  appLog("👌👌👌👌d${requestId}");
                                  appLog("👌👌👌👌d${chatId}");


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
