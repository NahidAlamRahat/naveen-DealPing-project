import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../utils/app_all_log/error_log.dart';
import '../../../../utils/app_log/error_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserEditProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();

  // Reactive variables
  final RxString name = ''.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxString profileImageUrl = ''.obs; // For network image URL
  final RxBool isLocalImage = false.obs; // Flag to track image type
  final RxBool isLoading = false.obs;
  final RxList<double> userLocation = <double>[].obs;

  // TextEditingController for the name field
  late TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();

    // Initialize with arguments from the previous screen
    final arguments = Get.arguments ?? {};

    // Handle name
    name.value = arguments['name'] ?? '';
    nameController = TextEditingController(text: name.value);

    // Sync the TextEditingController with the reactive variable
    nameController.addListener(() {
      name.value = nameController.text;
    });

    // Handle location data if available
    if (arguments['location'] != null) {
      if (arguments['location'] is List) {
        userLocation.value = List<double>.from(arguments['location']);
      }
    }

    // Handle profile image if passed
    if (arguments['profileImage'] != null) {
      if (arguments['profileImage'] is File) {
        // If it's already a File object
        profileImage.value = arguments['profileImage'];
        isLocalImage.value = true;
      } else if (arguments['profileImage'] is String) {
        // If it's a URL string
        profileImageUrl.value = arguments['profileImage'];
        isLocalImage.value = false;
      }
    }
  }

  @override
  void onClose() {
    // Dispose of the controller to free up resources
    nameController.dispose();
    super.onClose();
  }

  // Method to pick an image from the gallery or camera
  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        isLocalImage.value = true;
      }
    } catch (e) {
      errorLog(
        "pickImage error",
      );
      AppSnackBar.error("Failed to pick image.");
    }
  }

  // Method to take a photo from the camera
  Future<void> takePhoto() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        isLocalImage.value = true;
      }
    } catch (e) {
      errorLog(
        "takePhoto error",
      );
      AppSnackBar.error("Failed to take photo.");
    }
  }

  // Method to update the profile
  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      AppSnackBar.error("Please enter your name.");
      return;
    }

    isLoading.value = true;
    try {
      // Debugging
      errorLog(
        "Starting profile update",
      );

      // Send existing location data if available, otherwise omit it
      bool success = await _profileRepository.updateProfile(
        name: name.value,
        location: userLocation.isNotEmpty ? userLocation : null,
        imageFile: isLocalImage.value ? profileImage.value : null,
      );

      if (success) {
        Get.back(result: {'updated': true}); // Navigate back with result
      }
    } catch (e) {
      errorLog(
        "updateProfile controller error",
      );
      AppSnackBar.error("An error occurred while updating the profile.");
    } finally {
      isLoading.value = false;
    }
  }
}
