import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../controller/supportApiCallerController.dart';
import 'dropdown_widget.dart';

class SupportFormSection extends StatelessWidget {
  final bool isMain;
  final TextEditingController? problemController;

  const SupportFormSection({
    super.key,
    this.isMain = false,
    this.problemController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportRequestController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMain) const Divider(thickness: 1, height: 40),

        const TextWidget(
          text: AppStrings.selectSupportType,
          fontColor: AppColors.grey500,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        const SpaceWidget(spaceHeight: 8),

        // Support Type
        Obx(() => CustomDropdown<String>(
          items: controller.supportTypeList,
          selectedValue: isMain
              ? (controller.selectedSupportType.value.isEmpty
              ? null
              : controller.selectedSupportType.value)
              : null,
          hint: AppStrings.selectSupportType,
          onChanged: (newValue) {
            if (isMain && newValue != null) {
              controller.setSupportType(newValue);
            }
          },
        )),

        const SpaceWidget(spaceHeight: 20),

        // Category & SubCategory (main only)
        if (isMain)
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.selectedSupportType.value ==
                'Changed Category Name') {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown<String>(
                    items:
                    controller.categories.map((e) => e.title).toList(),
                    selectedValue:
                    controller.selectedCategory.value == "empty"
                        ? null
                        : controller.selectedCategory.value,
                    hint: AppStrings.selectCategory,
                    onChanged: (newValue) {
                      controller.setCategory(newValue ?? "");
                    },
                  ),
                  const SpaceWidget(spaceHeight: 20),

                  if (controller.selectedCategory.value != "empty")
                    Obx(() {
                      if (controller.selectedCategorySubcategories.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            "No subcategories available.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: controller
                              .selectedCategorySubcategories.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final sub = controller
                                .selectedCategorySubcategories[index];
                            final isSelected = controller.selectedSubCategories
                                .contains(sub);

                            return GestureDetector(
                              onTap: () {
                                controller.toggleSubCategory(sub);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  sub,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                ],
              );
            }

            return const SizedBox.shrink();
          }),

        const SpaceWidget(spaceHeight: 20),
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

         controller: isMain ? controller.writeProblemTEController : problemController,),
      ],
    );
  }
}
