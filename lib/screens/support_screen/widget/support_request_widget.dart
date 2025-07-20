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



import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

import '../controller/supportApiCallerController.dart';
import '../model/support_category.dart';
import '../widget/dropdown_widget.dart';

// class SupportRequestWidget extends StatelessWidget {
//
//   const SupportRequestWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GetBuilder<SupportRequestController>(
//         builder: (controller) {
//           return Scaffold(
//             backgroundColor: AppColors.white,
//
//
//             floatingActionButton: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ButtonWidget(
//                   onPressed: () {
//                     controller.addFormSection();
//                   },
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   buttonWidth: 52,
//                   buttonHeight: 52,
//                   buttonRadius: BorderRadius.circular(100),
//                 ),
//                 const SizedBox(height: 6), // spacing between button and text
//                 const TextWidget(
//                   text: AppStrings.addMoreProblem,
//                   fontColor: AppColors.grey500,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ],
//             ),
//
//
//             bottomNavigationBar:   Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ButtonWidget(
//                 onPressed: () {
//                   // Logic for send
//
//                 },
//                 label: AppStrings.send,
//                 buttonWidth: double.infinity,
//                 buttonHeight: 52,
//               ),
//             ),
//
//
//
//
//
//
//             body: Form(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const TextWidget(
//                         text: AppStrings.selectSupportType,
//                         fontColor: AppColors.grey500,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       const SpaceWidget(spaceHeight: 8),
//
//                       // Support Type Dropdown
//                       Obx(() =>  CustomDropdown<String>(
//                         items: controller.supportTypeList,
//                         selectedValue: controller.selectedSupportType.value.isEmpty
//                             ? null
//                             : controller.selectedSupportType.value,
//                         hint: AppStrings.selectSupportType,
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             controller.setSupportType(newValue);
//
//                           }
//                         },
//                       )),
//
//                       const SpaceWidget(spaceHeight: 20),
//
//
//                       Obx(() {
//                         if (controller.isLoading.value) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//
//                         if (controller.selectedSupportType.value == 'Changed Category Name') {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Category Dropdown
//                               CustomDropdown<String>(
//                                 items: controller.categories.map((e) => e.title).toList(),
//                                 selectedValue: controller.selectedCategory.value == "empty"
//                                     ? null
//                                     : controller.selectedCategory.value,
//                                 hint: AppStrings.selectCategory,
//                                 onChanged: (newValue) {
//                                   controller.setCategory(newValue ?? "");
//
//                                 },
//                               ),
//                               const SpaceWidget(spaceHeight: 20),
//
//                               // SubCategory Section
//                               if (controller.selectedCategory.value != "empty")
//                                 Obx(() {
//                                   if (controller.selectedCategorySubcategories.isEmpty) {
//                                     return const Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                       child: Text(
//                                         "No subcategories available.",
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     );
//                                   }
//
//                                   return SizedBox(
//                                     height: 40,
//                                     child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                                       itemCount: controller.selectedCategorySubcategories.length,
//                                       separatorBuilder: (_, __) => const SizedBox(width: 8),
//                                       itemBuilder: (context, index) {
//                                         final sub = controller.selectedCategorySubcategories[index];
//                                         final isSelected = controller.selectedSubCategories.contains(sub);
//
//                                         return GestureDetector(
//                                           onTap: () {
//                                             controller.toggleSubCategory(sub);
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                                             decoration: BoxDecoration(
//                                               color: isSelected ? Colors.black : Colors.white,
//                                               borderRadius: BorderRadius.circular(20),
//                                               border: Border.all(
//                                                 color: isSelected ? Colors.black : Colors.grey.shade300,
//                                               ),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               sub,
//                                               style: TextStyle(
//                                                 color: isSelected ? Colors.white : Colors.grey.shade800,
//                                                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 })
//
//                             ],
//                           );
//                         } else {
//                           return const SizedBox.shrink();
//                         }
//                       }),
//
//
//                       const SpaceWidget(spaceHeight: 50),
//
//                       const TextWidget(
//                         text: AppStrings.other,
//                         fontColor: AppColors.grey500,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       const SpaceWidget(spaceHeight: 8),
//
//                       TextFieldWidget(
//                         hintText: AppStrings.writeYourProblem,
//                         maxLines: 4,
//                         controller: controller.writeProblemTEController,
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
// }





class SupportRequestWidget extends StatelessWidget {
  const SupportRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportRequestController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,

          // Floating Action Button
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonWidget(
                onPressed: () {
                  controller.addFormSection(); // Add new section
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
          ),

          // Bottom Button
          bottomNavigationBar: Padding(
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
                    /// 🟢 Main form section (no const)
                    SupportFormSection(isMain: true),

                    /// 🔵 Dynamic additional form sections
                    Obx(() {
                      return Column(
                        children: controller.formSectionIds.map((formId) {
                          return SupportFormSection(
                            isMain: false,
                            problemController: TextEditingController(),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


