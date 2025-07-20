import 'package:deal_ping/screens/user_screens/user_home_screen/widgets/sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/user_home_controller.dart';

class SubCategoryView extends StatelessWidget {
  const SubCategoryView({super.key, required this . controller});
  final UserHomeController controller;
  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.subCategories.isEmpty) {
        return const Center(child: Text("No subcategories available."));
      }

      return SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.subCategories.map((subCategory) {
              return SubCategoryWidget(
                onTap: () => controller.selectSubCategory(subCategory),
                containerColor:
                controller.selectedSubCategory.value == subCategory
                    ? Colors.black
                    : Colors.white,
                text: subCategory,
                textColor: controller.selectedSubCategory.value == subCategory
                    ? Colors.white
                    : Colors.grey,
                textWeight: controller.selectedSubCategory.value == subCategory
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
