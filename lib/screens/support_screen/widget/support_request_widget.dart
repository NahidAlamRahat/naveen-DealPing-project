/*import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../controller/supportApiCallerController.dart';
import 'dropdown_widget.dart';

class SupportRequestWidget extends StatelessWidget {
  const SupportRequestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SupportRequestController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,

            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWidget(
                  onPressed: () {
                    controller.addFormSection();
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  buttonWidth: 52,
                  buttonHeight: 52,
                  buttonRadius: BorderRadius.circular(100),
                ),
                const SizedBox(height: 6), // spacing between button and text
                const TextWidget(
                  text: AppStrings.addMoreProblem,
                  fontColor: AppColors.grey500,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),


            bottomNavigationBar:   Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonWidget(
                onPressed: () {
                  // Logic for send
                },
                label: AppStrings.send,
                buttonWidth: double.infinity,
                buttonHeight: 52,
              ),
            ),


            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      // Existing form — no change
                      const TextWidget(
                        text: AppStrings.selectSupportType,
                        fontColor: AppColors.grey500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const SpaceWidget(spaceHeight: 8),

                      Obx(() => CustomDropdown<String>(
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

                      const SpaceWidget(spaceHeight: 40),

                      Obx(() =>
                          TextWidget(
                            text: controller.selectedSupportType.value,
                            fontColor: AppColors.grey500,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                      ),
                      const SpaceWidget(spaceHeight: 8),

                      TextFieldWidget(
                        hintText: AppStrings.writeYourProblem,
                        maxLines: 4,
                        controller: controller.writeProblemTEController,
                      ),

                      const SpaceWidget(spaceHeight: 16),


                      Obx(() => Column(
                        children: List.generate(controller.additionalForms.length, (index) {
                          final form = controller.additionalForms[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => controller.removeFormSection(index),
                                  child: Container(
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.green500),
                                    child: const Icon(Icons.remove,color: Colors.white,),
                                  ),
                                ),
                              ),

                              const TextWidget(
                                text: AppStrings.selectSupportType,
                                fontColor: AppColors.grey500,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              const SpaceWidget(spaceHeight: 8),

                              Obx(() => CustomDropdown<String>(
                                items: controller.supportTypeList,
                                selectedValue: form.selectedType.value.isEmpty
                                    ? null
                                    : form.selectedType.value,
                                hint: AppStrings.selectSupportType,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    controller.setAdditionalFormType(index, newValue);
                                  }
                                },
                              )),

                              const SpaceWidget(spaceHeight: 40),

                              Obx(() => TextWidget(
                                text: form.selectedType.value,
                                fontColor: AppColors.grey500,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                              const SpaceWidget(spaceHeight: 8),

                              TextFieldWidget(
                                hintText: AppStrings.writeYourProblem,
                                maxLines: 4,
                                controller: form.problemController,
                              ),
                              const SpaceWidget(spaceHeight: 30),
                            ],
                          );
                        }),
                      )),

                      const SpaceWidget(spaceHeight: 200),


                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}*/



import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

import '../../user_screens/user_home_screen/widgets/sub_category_widget.dart';
import '../controller/request_api_caller.dart';
import '../controller/supportApiCallerController.dart';
import '../model/support_category.dart';
import '../widget/dropdown_widget.dart';

/// error solve
class SupportRequestWidget extends StatelessWidget {

  const SupportRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {

   final _requestApiController = Get.put(RequestApiController());

    return GetBuilder<SupportRequestController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,



            floatingActionButton: Obx(() {
              return controller.canAddMoreSections
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      controller.addFormSection();
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    buttonWidth: 52,
                    buttonHeight: 52,
                    buttonRadius: BorderRadius.circular(100),
                  ),
                  const SizedBox(height: 6),
                  const TextWidget(
                    text: AppStrings.addMoreProblem,
                    fontColor: AppColors.grey500,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
                  : const SizedBox.shrink(); // Hide when max reached
            }),





            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return Visibility(
                  visible: _requestApiController.inProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ButtonWidget(
                    onPressed: () {
                      // Logic for send
                      controller.onTapSubmitSupportRequests();
                    },
                    label: AppStrings.send,
                    buttonWidth: double.infinity,
                    buttonHeight: 52,
                  ),
                );
              }),
            ),



            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child:

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,


                        children: [
                          // Render all form sections
                          ...controller.formSections.asMap().entries.map((entry) {
                            final index = entry.key;
                            final section = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              key: ValueKey(index),
                              children: [

                                const TextWidget(
                                  text: AppStrings.selectSupportType,
                                  fontColor: AppColors.grey500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SpaceWidget(spaceHeight: 8),

                                Obx(() => CustomDropdown<String>(
                                  items: controller.availableSupportTypes + (section.selectedType.value.isNotEmpty ? [section.selectedType.value] : []),
                                  selectedValue: section.selectedType.value.isEmpty ? null : section.selectedType.value,
                                  hint: "Select Support Type",
                                  onChanged: (value) => controller.setFormSectionType(index, value ?? ''),
                                )),



                                const SpaceWidget(spaceHeight: 8),

                                // Conditional Category/Subcategory fields
                                if (section.selectedType.value.contains('Category'))
                                  Column(
                                    children: [
                                      // Category Dropdown
                                      CustomDropdown<String>(
                                        items: controller.categories.map((e) => e.title).toList(),
                                        selectedValue: section.selectedCategory.value == "empty" ? null : section.selectedCategory.value,
                                        hint: "Select Category",
                                        onChanged: (value) => controller.setFormSectionCategory(index, value ?? "empty"),
                                      ),


                                      const SpaceWidget(spaceHeight: 20),

                                      // Subcategory selection
                                      if (section.selectedCategory.value != "empty")
                                        Wrap(
                                          spacing: 8,
                                          children: controller.getSubcategoriesFor(section.selectedCategory.value)
                                              .map((sub) => Obx(() => FilterChip(
                                            label: Text(sub),
                                            selected: section.selectedSubCategories.contains(sub),
                                            onSelected: (_) => controller.toggleFormSectionSubCategory(index, sub),
                                          )))
                                              .toList(),
                                        ),
                                    ],
                                  ),

                                if (['Other', 'Eiin Number', 'Business Name'].contains(section.selectedType.value))
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0), // Optional: for better spacing
                                    child: TextFieldWidget(
                                      hintText: '${AppStrings.writeYour} ${section.selectedType.value}',
                                      maxLines: 1,
                                      controller: section.inputFieldController,
                                    ),
                                  ),







                                const SpaceWidget(spaceHeight: 40),

                                Obx(() => TextWidget(

                                  text: section .selectedType.value,
                                  fontColor: AppColors.grey500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                                const SpaceWidget(spaceHeight: 8),

                                TextFieldWidget(
                                  hintText: AppStrings.writeYourProblem,
                                  maxLines: 4,
                                  controller: section.problemController,
                                ),

                                // Remove button (only show if not the last form)
                                if (controller.formSections.length > 1)
                                  TextButton(
                                    onPressed: () => controller.removeFormSection(index),
                                    child: Text("Remove"),
                                  ),
                              ],
                            );
                          }).toList(),

                        ],
                      )),
                    ],
                  ),


                ),
              ),
            ),
          );
        }
    );
  }
}










