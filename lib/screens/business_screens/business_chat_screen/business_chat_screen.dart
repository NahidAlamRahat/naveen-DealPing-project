import 'dart:io';

import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/screens/user_screens/user_chat_screen/controller/user_chate_controller.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/app_image/app_image.dart';
import 'package:deal_ping/widgets/icon_text_button/icon_text_button.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_icons_path.dart';
import '../../../models/chat_message_responce_model.dart';
import '../../../services/storage/storage_service.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../user_screens/user_chat_screen/widget/image_view.dart';
import '../../user_screens/user_chat_screen/widget/network_image_grid.dart';
import '../business_preset_screen/controller/business_present_screen_controller.dart';

class BusinessChatScreen extends StatefulWidget {
  const BusinessChatScreen({super.key});

  @override
  State<BusinessChatScreen> createState() => _BusinessChatScreenState();
}

class _BusinessChatScreenState extends State<BusinessChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  // UserChatController controller = Get.find<UserChatController>();


  final BusinessPresetScreenController offerController =
  Get.put(BusinessPresetScreenController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  UserChatController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white
          ,
          appBar: AppbarWidget(
            textWidget: Obx(() {
              final name = controller.chatMessages.isNotEmpty
                  ? controller.chatMessages[0].sender?.name
                  : null;

              if (name == null) {
                return const Text('Loading...');
              } else if (name.trim().isEmpty) {
                return const Text('Unknown');
              } else {
                return Text(name);
              }
            }),
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
                      Column(
                        children: [
                          TextField(
                            controller: offerController.titleController,
                            decoration: InputDecoration(
                              hintText: 'Offer Title',
                              hintStyle: const TextStyle(color: Colors.grey),
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

                          SizedBox(height: 8,),

                          TextField(
                            controller: offerController.descriptionController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: 'Offer Description',
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
                          )


                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildOfferButtonsRow(),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconTextButton(
                          onTap: () {
                            offerController.postOffer(
                              title: offerController.titleController.text,
                              description: offerController.descriptionController.text,
                            );
                          },
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

                      GetBuilder<UserChatController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.isMessageSent==false,
                            replacement: const Center(child: CircularProgressIndicator(),),
                            child: ButtonWidget(
                              onPressed: () {
                                controller.sendOffer(offerTitle: offerController.titleController.text,
                                    offerDescription: offerController.descriptionController.text);
                                Get.back();
                                appLog('offerTitle==> ${offerController.titleController.text}');
                                appLog('offerDes==>> ${offerController.descriptionController.text}');
                            
                              },
                              label: AppStrings.sendRequest,
                              buttonWidth: double.infinity,
                              buttonHeight: 45,
                              fontSize: 14,
                            ),
                          );
                        }
                      )
                    ],
                  );
                }
              },

              itemBuilder: (context) => [

             /*   const PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Report",
                    style: TextStyle(fontSize: 14, color: AppColors.grey300),
                  ),
                ),*/

                // const PopupMenuDivider(height: 0.5),
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


          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 8)).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.width(value: 10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //  Image preview chips
                Obx((){
                  if (controller.images.isEmpty) return const SizedBox();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.images.length, (index) {
                        final image = controller.images[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(image.path),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    controller.images.removeAt(index);
                                    controller.update();
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 18, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                },),

                const SizedBox(height: 8),

                // Message send Row
                Row(
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
                            color: AppColors.grey300,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
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
                      child:
                      GetBuilder<UserChatController>(builder: (controllers) {
                        return Visibility(
                          visible: controllers.isMessageSent == false,
                          replacement:
                          const Center(child: CircularProgressIndicator()),
                          child: FloatingActionButton(
                            onPressed: controller.sendMessage,
                            backgroundColor: AppColors.green500,
                            child: const Icon(Icons.send_rounded, color: AppColors.white),
                          ),
                        );
                      }),

                    ),
                  ],
                ),
              ],
            ),
          ),





          ///old body
          // body: Column(
          //   children: [
          //     Expanded(
          //       child: /*ListView.builder(
          //         padding: const EdgeInsets.all(16),
          //         itemCount: _messages.length,
          //         itemBuilder: (context, index) {
          //           final message = _messages[index];
          //           return ChatMessage(
          //             text: message['text'] as String?,
          //             // Cast as nullable String
          //             image: message['image'],
          //             isSent: message['isSent'] as bool,
          //             time: message['time'].toString() ,
          //             showButton: message['type'],
          //           );
          //         },
          //       ),*/
          //
          //
          //
          //       Obx(() {
          //         if (controller.isLoading.value) {
          //           return const Center(child: CircularProgressIndicator()); // Initial loading
          //         }
          //
          //         if (controller.chatMessages.isEmpty) {
          //           return const Center(child: Text('No messages available')); // No messages
          //         }
          //
          //         return ListView.builder(
          //           reverse: true,
          //           controller: controller.scrollController,
          //           padding: const EdgeInsets.all(16),
          //           physics: const ClampingScrollPhysics(),
          //           itemCount: controller.chatMessages.length +
          //               (controller.isLoading.value ? 1 : 0),
          //           itemBuilder: (context, index) {
          //             if (index == controller.chatMessages.length) {
          //               return const Padding(
          //                 padding: EdgeInsets.all(8.0),
          //                 child: CircularProgressIndicator(), // pagination loading
          //               );
          //             }
          //
          //             final message = controller.chatMessages[index];
          //
          //             return
          //               ChatMessage(
          //                 text: message.message,
          //                 isSent: message.sender?.id == LocalStorage.userId,
          //                 time: (DateTime.tryParse(message.createdAt.toString()) ??
          //                     DateTime.now())
          //                     .time,
          //                 image: message.images,
          //                 showButton: message.type ?? 'text',
          //                 message: controller.chatMessages[index],
          //
          //               );
          //
          //           },
          //         );
          //       }),
          //
          //
          //
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         children: [
          //           IconButton(
          //             icon: const Icon(Icons.image, color: Colors.green, size: 32),
          //             onPressed: _pickImage,
          //           ),
          //           Expanded(
          //             child: TextField(
          //               controller: _controller,
          //               decoration: InputDecoration(
          //                 hintText: 'Type a message...',
          //                 hintStyle: const TextStyle(
          //                     color: AppColors.grey300,
          //                     fontWeight: FontWeight.w400,
          //                     fontSize: 14),
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(8),
          //                   borderSide: const BorderSide(color: AppColors.grey300),
          //                 ),
          //                 filled: true,
          //                 fillColor: AppColors.white,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(width: 8.0),
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(100),
          //             child: FloatingActionButton(
          //               onPressed: () => _sendMessage(),
          //               backgroundColor: AppColors.green500,
          //               child: const Icon(
          //                 Icons.send_rounded,
          //                 color: AppColors.white,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),


          ///new body
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator()); // Initial loading
            }

            if (controller.chatMessages.isEmpty) {
              return const Center(child: Text('No messages available')); // No messages
            }

            return  ListView.builder(
              reverse: true,
              controller: controller.scrollController,
              padding: const EdgeInsets.all(16),
              physics: const ClampingScrollPhysics(),
              itemCount: controller.chatMessages.length +
                  (controller.isLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.chatMessages.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(), // pagination loading
                  );
                }

                final message = controller.chatMessages[index];

                return
                  ChatMessage(
                    text: message.message,
                    isSent: message.sender?.id == LocalStorage.userId,
                    time: (DateTime.tryParse(message.createdAt.toString()) ??
                        DateTime.now())
                        .time,
                    image: message.images,
                    showButton: message.type ?? 'text',
                    message: controller.chatMessages[index],

                  );



              },
            );
          }),

        );
      }
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

  final ChatMessageResponseModel? message;
  final String? text;
  final List<String> ? image;
  final bool isSent;
  final String time;
  final String showButton;

  const ChatMessage({

    super.key,
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
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // 👈 Rounded corners
                                  ),
                                ),
                                child: const Text('Accept'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // 👈 Rounded corners
                                  ),
                                ),
                                child: const Text('message'),
                              ),
                            ],
                          )


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
