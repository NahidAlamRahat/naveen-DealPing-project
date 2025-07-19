import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../controller/sub_category_api_caller.dart';
import '../controller/supportApiCallerController.dart';
import '../widget/dropdown_widget.dart';

class SupportScreen extends StatelessWidget {
  // final SupportRequestController controller = Get.put(SupportRequestController());

 const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SupportRequestController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: const AppbarWidget(
            text: AppStrings.supportRequestScreen,
            centerTitle: true,
          ),
          body: Form(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: AppStrings.selectSupportType,
                          fontColor: AppColors.grey500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const SpaceWidget(spaceHeight: 8),

                        // Support Type Dropdown
                     Obx(() =>  CustomDropdown<String>(
                       items: controller.supportTypeList,
                       selectedValue: controller.selectedSupportType.value.isEmpty
                           ? null
                           : controller.selectedSupportType.value,
                       hint: AppStrings.selectSupportType,
                       onChanged: (newValue) {
                         if (newValue != null) {
                           controller.setSupportType(newValue);
                         }
                       },
                     )),

                        const SpaceWidget(spaceHeight: 20),


                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (controller.selectedSupportType.value == 'Changed Category Name') {
                            return Column(
                              children: [
                                CustomDropdown<String>(
                                  items: controller.categories.map((e) => e.title).toList(),
                                  selectedValue: controller.selectedCategory.value == "empty"
                                      ? null
                                      : controller.selectedCategory.value,
                                  hint: AppStrings.selectCategory,
                                  onChanged: (newValue) {
                                    controller.setCategory(newValue ?? "");
                                  },
                                ),
                                const SpaceWidget(spaceHeight: 20),

                                if (controller.selectedCategory.value != "empty")
                                  GetBuilder<SubCategoryApiController>(
                                    builder: (subCategoryController) {
                                      if (subCategoryController.isLoading) {
                                        return const Center(child: CircularProgressIndicator());
                                      }

                                      return CustomDropdown<String>(
                                        items: subCategoryController.subCategoryList
                                            .map((e) => e.title)
                                            .toList(),
                                        selectedValue: controller.selectedSubCategory.value == "empty"
                                            ? null
                                            : controller.selectedSubCategory.value,
                                        hint: AppStrings.selectSubCategory,
                                        onChanged: (newValue) {
                                          controller.setSubCategory(newValue ?? "");
                                        },
                                      );
                                    },
                                  ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),



                        const SpaceWidget(spaceHeight: 50),

                        const TextWidget(
                          text: AppStrings.other,
                          fontColor: AppColors.grey500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const SpaceWidget(spaceHeight: 8),

                        TextFieldWidget(
                          hintText: AppStrings.writeYourProblem,
                          maxLines: 4,
                          controller: controller.writeProblemTEController,
                        ),
                        const SpaceWidget(spaceHeight: 200),

                        ButtonWidget(
                          onPressed: () {
                            // Logic for send
                          },
                          label: AppStrings.send,
                          buttonWidth: double.infinity,
                          buttonHeight: 52,
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  right: 20,
                  bottom: 100,
                  child: ButtonWidget(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                    buttonWidth: 52,
                    buttonHeight: 52,
                    buttonRadius: BorderRadius.circular(100),
                  ),
                ),

                const Positioned(
                  right: 20,
                  bottom: 80,
                  child: TextWidget(
                    text: AppStrings.addMoreProblem,
                    fontColor: AppColors.grey500,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
