import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:deal_ping/widgets/text_widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import 'controller/business_edit_profile_controller.dart';

class BusinessEditProfileScreen extends StatelessWidget {
  const BusinessEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller
    final BusinessEditProfileController controller =
        Get.put(BusinessEditProfileController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.editProfile,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Image
              Center(
                child: Obx(() {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.green500, width: 2),
                        ),
                        child: controller.profileImage.value != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(controller.profileImage.value!),
                              )
                            : const ImageWidget(
                                height: 120,
                                width: 120,
                                imagePath: AppImagePath.businessProfileImage,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            // Show bottom sheet for image selection
                            Get.bottomSheet(
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Choose from Gallery'),
                                      onTap: () {
                                        controller.pickImage();
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Take a Photo'),
                                      onTap: () {
                                        controller.takePhoto();
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              border: Border.fromBorderSide(
                                BorderSide(
                                    color: AppColors.green500, width: 1.5),
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.green500,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Name Field
              const Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  text: 'Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.green500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.nameController,
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ButtonWidget(
          onPressed: controller.saveChanges,
          backgroundColor: AppColors.green500,
          label: AppStrings.saveAndChange,
          buttonHeight: 52,
          buttonWidth: double.infinity,
          fontSize: 16,
          textColor: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
