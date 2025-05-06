import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/screens/user_screens/user_home_screen/widgets/category_widget.dart';
import 'package:deal_ping/screens/user_screens/user_home_screen/widgets/home_screen_input_widget.dart';
import 'package:deal_ping/screens/user_screens/user_home_screen/widgets/sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import 'controller/user_home_controller.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final UserHomeController _controller = Get.put(UserHomeController());
  double _currentValue = 5.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Category Section**
          _buildCategoryView(),
          const SpaceWidget(spaceHeight: 12),

          // **Sub-Category Section (Conditional)**
          Obx(() {
            if (_controller.selectedCategory.value.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubCategoryView(),
                  const SpaceWidget(spaceHeight: 12),
                ],
              );
            }
            return const SizedBox.shrink();
          }),

          // **Location and Distance Input**
          HomeScreenInputWidget(
            controller: _controller.locationController,
            hintText: "Location",
            onLocationTap: _controller.navigateToLocationScreen,
          ),
          const SpaceWidget(spaceHeight: 12),
          const Text(
            "Distance",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.grey200,
            ),
          ),
          const SpaceWidget(spaceHeight: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      overlayShape: SliderComponentShape.noOverlay,
                      trackHeight: 5),
                  child: Slider(
                    value: _currentValue,
                    min: 0,
                    max: 50,
                    divisions: 50,
                    inactiveColor: AppColors.grey50,
                    activeColor: AppColors.green500,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                ),
              ),
              const SpaceWidget(spaceWidth: 24),
              Text(
                '${_currentValue.round()} ${"mile".tr}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
          const SpaceWidget(spaceHeight: 16),
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
          const SpaceWidget(spaceHeight: 24),
        ],
      ),
    );
  }

  // **Category View**
  Widget _buildCategoryView() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (_controller.categories.isEmpty) {
        return const Center(child: Text("No categories available."));
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _controller.categories.map((category) {
            return CategoryWidget(
              onTap: () => _controller.selectCategory(category.title ?? ""),
              containerColor:
                  _controller.selectedCategory.value == category.title
                      ? AppColors.green100
                      : Colors.transparent,
              imagePath: category.icon ?? "",
              text: category.title ?? "",
              textWeight: _controller.selectedCategory.value == category.title
                  ? FontWeight.w600
                  : FontWeight.w400,
            );
          }).toList(),
        ),
      );
    });
  }

  // **Sub-Category View**
  Widget _buildSubCategoryView() {
    return Obx(() {
      if (_controller.subCategories.isEmpty) {
        return const Center(child: Text("No subcategories available."));
      }

      return SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _controller.subCategories.map((subCategory) {
              return SubCategoryWidget(
                onTap: () => _controller.selectSubCategory(subCategory),
                containerColor:
                    _controller.selectedSubCategory.value == subCategory
                        ? Colors.black
                        : Colors.white,
                text: subCategory,
                textColor: _controller.selectedSubCategory.value == subCategory
                    ? Colors.white
                    : Colors.grey,
                textWeight: _controller.selectedSubCategory.value == subCategory
                    ? FontWeight.w500
                    : FontWeight.normal,
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
