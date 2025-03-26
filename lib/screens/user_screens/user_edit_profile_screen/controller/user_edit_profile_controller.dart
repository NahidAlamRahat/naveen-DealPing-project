import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserEditProfileController extends GetxController {
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString address = ''.obs;

  // Reactive variable for profile image
  final Rx<File?> profileImage = Rx<File?>(null);

  // TextEditingControllers for the text fields
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  // Image Picker
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    // Initialize the controllers with empty strings
    nameController = TextEditingController(text: name.value);
    emailController = TextEditingController(text: email.value);
    addressController = TextEditingController(text: address.value);

    // Sync the TextEditingControllers with the reactive variables
    nameController.addListener(() {
      name.value = nameController.text;
    });
    emailController.addListener(() {
      email.value = emailController.text;
    });
    addressController.addListener(() {
      address.value = addressController.text;
    });
  }

  @override
  void onClose() {
    // Dispose of the controllers to free up resources
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
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
    if (name.value.isEmpty) {
      Get.snackbar('Error', 'Name cannot be empty');
      return;
    }
    if (email.value.isEmpty || !email.value.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }
    if (address.value.isEmpty) {
      Get.snackbar('Error', 'Address cannot be empty');
      return;
    }

    // Save the changes (e.g., update user profile in backend or local storage)
    // For now, we'll just show a success message and navigate back
    Get.snackbar('Success', 'Profile updated successfully');

    // Navigate back with updated values
    Get.back(result: {
      'name': name.value,
      'email': email.value,
      'address': address.value,
      'profileImage': profileImage.value,
    });
  }
}
