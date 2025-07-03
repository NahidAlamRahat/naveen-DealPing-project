/*
import 'package:deal_ping/models/sent_home_screen_data_model.dart';
import 'package:deal_ping/models/user_sign_up_model.dart';
import 'package:deal_ping/screens/user_screens/user_home_screen/controller/sent_request_api_caller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/auth_repository/sign_up_api_controller.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../models/category_model.dart';

class UserSignUpButtonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Text Controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final RxBool isLoading = false.obs;

  var categories = <Data>[].obs;
  var subCategories = <String>[].obs;

  // Selected Values
  var selectedCategory = "".obs; // Initially empty (no selection)
  var selectedSubCategory = "".obs; // Initially empty (no selection)

  final SentRequestController _SentRequestController =
      Get.find<SentRequestController>();




  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }
}
*/
