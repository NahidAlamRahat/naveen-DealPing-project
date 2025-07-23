import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../controller/request_api_caller.dart';
import '../controller/support_controller.dart';
import '../widget/dropdown_widget.dart';

/// error solve
class SupportRequestWidget extends StatelessWidget {

  const SupportRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {

   final _requestApiController = Get.put(RequestApiController());

    return GetBuilder<SupportController>(
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
                                        items: controller.categories.map((e) => e.title ?? '').toList(),
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
                                            label: Text(sub.title ?? ''),
                                            selected: section.selectedSubCategories.contains(sub.id),
                                            onSelected: (_) => controller.toggleFormSectionSubCategory(index, sub.id ?? ''),
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










