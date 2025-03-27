import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessEditProfileController extends GetxController {
  final RxString name = ''.obs;
  final RxString zipCode = ''.obs;
  final RxString city = ''.obs;

  // Reactive variable for profile image
  final Rx<File?> profileImage = Rx<File?>(null);

  // TextEditingControllers for the text fields
  late TextEditingController nameController;
  late TextEditingController zipcodeController;
  late TextEditingController cityController;

  // Image Picker
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    // Initialize the controllers with empty strings
    nameController = TextEditingController(text: name.value);
    zipcodeController = TextEditingController(text: zipCode.value);
    cityController = TextEditingController(text: city.value);

    // Sync the TextEditingControllers with the reactive variables
    nameController.addListener(() {
      name.value = nameController.text;
    });
    zipcodeController.addListener(() {
      zipCode.value = zipcodeController.text;
    });
    cityController.addListener(() {
      city.value = cityController.text;
    });
  }

  @override
  void onClose() {
    // Dispose of the controllers to free up resources
    nameController.dispose();
    zipcodeController.dispose();
    cityController.dispose();
    super.onClose();
  }

  // Method to pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to take photo from camera
  Future<void> takePhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to take photo',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveChanges() {
    // Validate the inputs

    // Save the changes (e.g., update user profile in backend or local storage)
    // For now, we'll just show a success message and navigate back
    Get.snackbar('Success', 'Profile updated successfully');

    // Navigate back with updated values
    Get.back(result: {
      'name': name.value,
      'zipcode': zipCode.value,
      'city': city.value,
      'profileImage': profileImage.value,
    });
  }
}
