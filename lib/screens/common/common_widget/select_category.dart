import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../support_screen/widget/dropdown_widget.dart';
import '../common_controller/select_category_and_sub_category.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({
    super.key,
    required this.selectCategoryController,
  });

  final SelectCategoryAndSubCategory selectCategoryController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown<String>(
          items: selectCategoryController.categories.map((e) => e.title ?? '').toList(),
          selectedValue: selectCategoryController.selectedCategory.value == "empty" ? null : selectCategoryController.selectedCategory.value,
          hint: "Select Category",
          onChanged: selectCategoryController.selectCategory,
        ),

        if (selectCategoryController.selectedCategory.value != "empty")
          Wrap(
            spacing: 8,
            children: selectCategoryController.getSubcategoriesFor(selectCategoryController.selectedCategory.value)
                .map((sub) => Obx(() => FilterChip(
              label: Text(sub.title ?? ''),
              selected: selectCategoryController.selectedSubCategories.contains(sub.id),
              onSelected: (_) => selectCategoryController.toggleSubCategory(sub.id ?? ''),
            )))
                .toList(),
          )
      ],
    ));
  }
}
