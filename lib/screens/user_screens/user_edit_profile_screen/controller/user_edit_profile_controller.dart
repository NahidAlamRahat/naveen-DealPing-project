import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../utils/app_log/error_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserEditProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();

  final Rx<File?> profileImage = Rx<File?>(null);
  final RxString profileImageUrl = ''.obs;
  final RxBool isLocalImage = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<double> userLocation = <double>[].obs;

   TextEditingController firstName = TextEditingController();
   TextEditingController lastName = TextEditingController();

  Future<void> onAppInitialDataLoad() async {
    try {
      final arguments = Get.arguments ?? {};

      firstName.text = arguments['name'] ?? '';
      lastName.text = arguments['lastName'] ?? '';

      if (arguments['location'] is List) {
        userLocation.value = List<double>.from(arguments['location']);
      }

      if (arguments['profileImage'] != null) {
        if (arguments['profileImage'] is File) {
          profileImage.value = arguments['profileImage'];
          isLocalImage.value = true;
        } else if (arguments['profileImage'] is String) {
          profileImageUrl.value = arguments['profileImage'];
          isLocalImage.value = false;
        }
      }
    } catch (e) {
      errorLog("onAppInitialDataLoad error: $e");
    }
  }


  @override
  void onInit() {
    onAppInitialDataLoad();
    super.onInit();
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    super.onClose();
  }

  Future<void> pickImage({required bool fromCamera}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        isLocalImage.value = true;
      }
    } catch (e) {
      errorLog("Image picking failed");
      AppSnackBar.error("Failed to select image.");
    }
  }

/*
  Future<void> updateProfile() async {
    if (firstName.text.trim().isEmpty) {
      AppSnackBar.error("Please enter your first name.");
      return;
    }

    isLoading.value = true;
    try {
      final success = await _profileRepository.updateProfile(
        name:firstName.text.trim() ,
        lastName: lastName.text.trim(),
        location: userLocation.isNotEmpty ? userLocation : null,
        imageFile: isLocalImage.value ? profileImage.value : null,
      );



      if (success) {
        Get.back(result: {'updated': true});
        AppSnackBar.message('profile updated successfully');
      }
    } catch (e) {
      errorLog("updateProfile controller error");
      AppSnackBar.error("An error occurred while updating the profile.");
    } finally {
      isLoading.value = false;
    }
  }
*/


  Future<void> updateProfile(BuildContext context) async {
    if (firstName.text.trim().isEmpty) {
      AppSnackBar.error("Please enter your first name.");
      return;
    }

    isLoading.value = true;  // Show loading indicator
    try {
      final success = await _profileRepository.updateProfile(
        name: firstName.text.trim(),
        lastName: lastName.text.trim(),
        location: userLocation.isNotEmpty ? userLocation : null,
        imageFile: isLocalImage.value ? profileImage.value : null,
      );

      if (success) {
        // AppSnackBar.success("Profile updated successfully.");
        // Get.back(result: {'updated': true});
        Navigator.pop(context,true);
      } else {
        AppSnackBar.error("Profile update failed. Please try again.");
      }
    } catch (e) {
      errorLog("updateProfile controller error");
      AppSnackBar.error("An error occurred while updating the profile.");
    } finally {
      isLoading.value = false;  // Hide loading indicator
    }
  }



}
