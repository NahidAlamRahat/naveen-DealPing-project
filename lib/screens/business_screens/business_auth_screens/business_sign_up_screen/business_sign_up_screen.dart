import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../../../support_screen/controller/support_controller.dart';
import '../../../support_screen/widget/dropdown_widget.dart';
import 'controller/business_sign_up_controller.dart';

class BusinessSignUpScreen extends StatelessWidget {
  BusinessSignUpScreen({super.key});

  final BusinessSignUpController controller =
      Get.put(BusinessSignUpController());
  final SupportController supportController =
  Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceWidget(spaceHeight: 24),
                const ImageWidget(
                  height: 60,
                  width: 60,
                  imagePath: AppImagePath.appLogoGreen,
                  fit: BoxFit.contain,
                ),
                const SpaceWidget(spaceHeight: 30),
                const TextWidget(
                  text: AppStrings.signUp,
                  fontColor: AppColors.green500,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SpaceWidget(spaceHeight: 8),
                const TextWidget(
                  text: AppStrings.signUpDescription,
                  fontColor: AppColors.grey700,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
                const SpaceWidget(spaceHeight: 12),

                // Business Name
                const TextWidget(
                  text: "Business Name",
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),

                TextFieldWidget(
                  controller: controller.businessNameController,
                  hintText: 'Enter Business Name',
                  maxLines: 1,
                  validator: controller.validateBusinessName,
                ),

                const SpaceWidget(spaceHeight: 12),


                const TextWidget(
                  text: "Category Name",
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Render all form sections
                    ...supportController.formSections.asMap().entries.map((entry) {
                      final index = entry.key;
                      final section = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        key: ValueKey(index),
                        children: [

                          // Conditional Category/Subcategory fields
                          Column(
                            children: [
                              // Category Dropdown
                              CustomDropdown<String>(
                                items: supportController.categories.map((e) => e.title ?? '').toList(),
                                selectedValue: section.selectedCategory.value == "empty" ? null : section.selectedCategory.value,
                                hint: "Select Category",
                                onChanged: (value) => supportController.setFormSectionCategory(index, value ?? "empty"),
                              ),



                              // Subcategory selection
                              if (section.selectedCategory.value != "empty")
                                Wrap(
                                  spacing: 8,
                                  children: supportController.getSubcategoriesFor(section.selectedCategory.value)
                                      .map((sub) => Obx(() => FilterChip(
                                    label: Text(sub.title ?? ''),
                                    selected: section.selectedSubCategories.contains(sub.id),
                                    onSelected: (_) => supportController.toggleFormSectionSubCategory(index, sub.id ?? ''),
                                  )))
                                      .toList(),
                                ),
                            ],
                          ),


                          Obx(() => TextWidget(

                            text: section .selectedType.value,
                            fontColor: AppColors.grey500,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),

                        ],
                      );
                    }).toList(),

                  ],
                )),


                const SpaceWidget(spaceHeight: 4),

                //EIIN Number
                const TextWidget(
                  text: AppStrings.eiinNumber,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.eiinNumberController,
                  hintText: 'Enter Your EIIN Number',
                  maxLines: 1,
                  validator: controller.validateEiinNumber,
                ),
                const SpaceWidget(spaceHeight: 12),

                //Licence Number
                const TextWidget(
                  text: AppStrings.licenceNumber,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.licenceNumberController,
                  hintText: 'Enter Your Licence Number',
                  maxLines: 1,
                  validator: controller.validateLicenseNumber,
                ),
                const SpaceWidget(spaceHeight: 12),

                // Email
                const TextWidget(
                  text: AppStrings.email,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.emailController,
                  hintText: 'Enter Your E-Mail',
                  maxLines: 1,
                  validator: controller.validateEmail,
                ),
                const SpaceWidget(spaceHeight: 12),

                // Password
                const TextWidget(
                  text: AppStrings.password,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.passwordController,
                  hintText: ' Create a Password',
                  maxLines: 1,
                  validator: controller.validatePassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),
                const SpaceWidget(spaceHeight: 12),

                // Re-type Password
                const TextWidget(
                  text: AppStrings.confirmPassword,
                  fontColor: AppColors.green500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SpaceWidget(spaceHeight: 4),
                TextFieldWidget(
                  controller: controller.confirmPasswordController,
                  hintText: 'Retype your password',
                  maxLines: 1,
                  validator: controller.validateRePassword,
                  suffixIcon: AppIconsPath.visibilityOff,
                ),

                const SpaceWidget(spaceHeight: 24),
                ButtonWidget(
                  onPressed: controller.onTapBusinessSignUpButton,
                  label: AppStrings.createYourAccount,
                  buttonWidth: double.infinity,
                  buttonRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                const SpaceWidget(spaceHeight: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: AppStrings.alreadyHaveAnAccount,
                      fontColor: AppColors.grey300,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SpaceWidget(spaceWidth: 4),
                    TextButtonWidget(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.businessSignInScreen);
                      },
                      text: AppStrings.signInTitle,
                      textColor: AppColors.grey700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SpaceWidget(spaceHeight: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
