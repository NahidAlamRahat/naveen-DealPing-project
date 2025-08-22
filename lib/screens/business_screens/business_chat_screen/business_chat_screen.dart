import 'dart:io';
import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/screens/user_screens/user_chat_screen/controller/user_chate_controller.dart';
import 'package:deal_ping/utils/extension.dart';
import 'package:deal_ping/widgets/icon_text_button/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/storage/storage_service.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';

import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../../common/common_widget/chat_message_widget.dart';
import '../../user_screens/user_profile_screen/controller/user_profile_controller.dart';
import '../business_preset_screen/controller/business_present_screen_controller.dart';
import 'controller/business_chat_controller.dart';

class BusinessChatScreen extends StatefulWidget {
  const BusinessChatScreen({super.key});

  @override
  State<BusinessChatScreen> createState() => _BusinessChatScreenState();
}

class _BusinessChatScreenState extends State<BusinessChatScreen> {
  // final TextEditingController _controller = TextEditingController();
  // final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  final BusinessPresetScreenController offerController =
  Get.put(BusinessPresetScreenController());
  // final userProfile = Get.put(UserProfileController()).profile.value;



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  BusinessChatController(),
      builder: (businessChatController) {
        return Scaffold(
          backgroundColor: AppColors.white
          ,
          appBar: AppbarWidget(
            textWidget: Obx(() {
              final name = businessChatController.chatMessagesList.isNotEmpty
                  ? businessChatController.chatMessagesList[0].receiver?.name
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

                      Row(
                        children: [
                          const Expanded(
                            child: Center(
                              child: TextWidget(
                                text: AppStrings.bookingRequest,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.grey700,
                                textAlignment: TextAlign.center,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20, color: AppColors.grey500),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
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
                      /// offer sent

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: offerController.titleController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Title is required';
                                }
                                return null;
                              },
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: offerController.descriptionController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Description is required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Offer Description',
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 16),
                      _buildOfferButtonsRow(),
                      const SizedBox(height: 18),

                      /// oofer save
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

                      GetBuilder<BusinessChatController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.isMessageSent == false,
                            replacement: const Center(child: CircularProgressIndicator()),
                            child: ButtonWidget(
                              onPressed: () {
                                // Validate the form before proceeding
                                if (_formKey.currentState!.validate()) {

                                  controller.sendOffer(
                                    offerTitle: offerController.titleController.text,
                                        offerDescription: offerController.descriptionController.text,
                                  );

                                  Get.back();
                                }

                              },
                              label: AppStrings.sendRequest,
                              buttonWidth: double.infinity,
                              buttonHeight: 45,
                              fontSize: 14,
                            ),
                          );
                        },
                      )

                    ],
                  );
                }
              },

              itemBuilder: (context) => [
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

              color: AppColors.white,
              elevation: 2,
            )


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
                  if (businessChatController.images.isEmpty) return const SizedBox();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(businessChatController.images.length, (index) {
                        final image = businessChatController.images[index];
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
                                    businessChatController.images.removeAt(index);
                                    businessChatController.update();
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
                      onPressed: businessChatController.pickImage,
                    ),
                    Expanded(
                      child: TextField(
                        controller: businessChatController.messageController,
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
                      GetBuilder<BusinessChatController>(builder: (controllers) {
                        return Visibility(
                          visible: controllers.isMessageSent == false,
                          replacement:
                          const Center(child: CircularProgressIndicator()),
                          child: FloatingActionButton(
                            onPressed: () =>  businessChatController.sendMessage(),

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



          ///new body
          body: Obx(() {
            if (businessChatController.isLoading.value) {
              return const Center(child: CircularProgressIndicator()); // Initial loading
            }

            if (businessChatController.chatMessagesList.isEmpty) {
              return const Center(child: Text('No messages available')); // No messages
            }

            return ListView.builder(
              reverse: true,
              controller: businessChatController.scrollController,
              padding: const EdgeInsets.all(16),
              physics: const ClampingScrollPhysics(),
              itemCount: businessChatController.chatMessagesList.length +
                  (businessChatController.isLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == businessChatController.chatMessagesList.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(), // pagination loading
                  );
                }

                final message = businessChatController.chatMessagesList[index];

                return
                  ChatMessage(
                    text: message.message,
                    isSent: message.sender?.id == LocalStorage.userId,
                    time: (DateTime.tryParse(message.createdAt.toString()) ??
                        DateTime.now())
                        .time,
                    image: message.images,
                    showButton: message.type ?? 'text',
                    chatMessageResponseModelList: businessChatController.chatMessagesList[index],

                  );

              },
            );
          }),

        );
      }
    );
  }




  Widget _buildOfferButton({
    required String offerTitle,
    required String? offerDescription,
    required int index,
  }) {
    return Obx(() {
      final isSelected = offerController.selectedOfferIndex.value == index;

      return InkWell(
        onTap: () {
          offerController.titleController.text = offerTitle.trim();
          offerController.descriptionController.text = offerDescription?.trim() ?? '';
          offerController.selectedOfferIndex.value = index;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(


              color: isSelected ? const Color.fromRGBO(230, 244, 236, 1) : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: AppColors.green100, width: 1.5)
                : Border.all(color: Colors.transparent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                offerTitle,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? Colors.black : AppColors.grey300,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 5),
              InkWell(

                onTap: () {
                  Get.defaultDialog(
                    title: "Confirm Delete!",
                    middleText: "Are you sure you want to delete this offer?",
                    textCancel: "Cancel",
                    textConfirm: "Delete",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      offerController.deleteOffer(
                        offerId: offerController.allOffersList[index].id,
                      );
                      Get.back();
                    },
                  );
                },

                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.black,
                ),
              ),

            ],
          ),
        ),
      );
    });
  }


  Widget _buildOfferButtonsRow() {
    return SizedBox(
      height: 30,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offerController.allOffersList.length,
        itemBuilder: (context, index) {
          final offer = offerController.allOffersList[index];
          return _buildOfferButton(
            offerTitle: offer.title,
            offerDescription: offer.description,
            index: index,
          );
        },
      )),
    );
  }


}

