import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/screens/user_screens/user_home_screen/widgets/home_screen_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/user_home_controller.dart';

class UserHomeScreen extends StatelessWidget {
  final UserHomeController _controller = Get.put(UserHomeController());

  UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.green50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceWidget(spaceHeight: 54),
            const TextWidget(
              text: AppStrings.welcome,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.grey700,
            ),
            const SpaceWidget(spaceHeight: 4),
            const TextWidget(
              text: AppStrings.findDeals,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.grey300,
              textAlignment: TextAlign.start,
            ),
            const SpaceWidget(spaceHeight: 12),

            // **Category Dropdown**
            GestureDetector(
              onTap: _controller.toggleCategoryExpanded,
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.green200, width: 0.5),
                    ),
                    child: _controller.isCategoryExpanded.value
                        ? _buildCategoryExpandedView()
                        : _buildCategoryCollapsedView(),
                  )),
            ),
            const SpaceWidget(spaceHeight: 12),

            // **Sub-Category Dropdown**
            GestureDetector(
              onTap: _controller.toggleSubCategoryExpanded,
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.green200, width: 0.5),
                    ),
                    child: _controller.isSubCategoryExpanded.value
                        ? _buildSubCategoryExpandedView()
                        : _buildSubCategoryCollapsedView(),
                  )),
            ),
            const SpaceWidget(spaceHeight: 12),

            // **Location and Distance Input**
            Row(
              children: [
                Expanded(
                  child: HomeScreenInputWidget(
                    controller: _controller.locationController,
                    hintText: "Location",
                    onLocationTap: _controller.navigateToLocationScreen,
                  ),
                ),
                const SpaceWidget(spaceWidth: 12),
                Expanded(
                  child: HomeScreenInputWidget(
                    controller: _controller.distanceController,
                    hintText: "Distance",
                  ),
                ),
              ],
            ),
            const SpaceWidget(spaceHeight: 12),

            // **Message Input**
            HomeScreenInputWidget(
              controller: _controller.messageController,
              hintText: "Write down your message",
              maxLines: 8,
              showCharacterCounter: true,
            ),

            // **Send Button**
            Align(
              alignment: Alignment.centerRight,
              child: ButtonWidget(
                onPressed: () {},
                buttonWidth: 80,
                buttonHeight: 36,
                label: AppStrings.send,
                fontSize: 14,
                buttonRadius: BorderRadius.circular(8),
              ),
            ),
            const SpaceWidget(spaceHeight: 54),
          ],
        ),
      ),
    );
  }

  // **Category Collapsed View**
  Widget _buildCategoryCollapsedView() {
    return Obx(() => Text(
          _controller.selectedCategory.value,
          style: TextStyle(
            color: _controller.selectedCategory.value == "Category"
                ? AppColors.grey200
                : AppColors.grey700,
            fontSize: 14,
          ),
        ));
  }

  // **Category Expanded View**
  Widget _buildCategoryExpandedView() {
    return SizedBox(
      height: 150,
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _controller.subCategories.keys.map((category) {
              return GestureDetector(
                onTap: () => _controller.selectCategory(category),
                child: Obx(() => Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: _controller.selectedCategory.value == category
                            ? Colors.green.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                _controller.selectedCategory.value == category
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                _controller.selectedCategory.value == category
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    )),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // **Sub-Category Collapsed View**
  Widget _buildSubCategoryCollapsedView() {
    return Obx(() => Text(
          _controller.selectedSubCategory.value,
          style: TextStyle(
            color: _controller.selectedSubCategory.value == "Sub-Category"
                ? AppColors.grey200
                : AppColors.grey700,
            fontSize: 14,
          ),
        ));
  }

  // **Sub-Category Expanded View**
  Widget _buildSubCategoryExpandedView() {
    return SizedBox(
      height: 150,
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _controller
                .subCategories[_controller.selectedCategory.value]!
                .map((subCategory) {
              return GestureDetector(
                onTap: () => _controller.selectSubCategory(subCategory),
                child: Obx(() => Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color:
                            _controller.selectedSubCategory.value == subCategory
                                ? Colors.green.withOpacity(0.2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          subCategory,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: _controller.selectedSubCategory.value ==
                                    subCategory
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _controller.selectedSubCategory.value ==
                                    subCategory
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ),
                    )),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
