import 'package:deal_ping/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/app_colors.dart';
import '../widgets/appbar_widget/appbar_widget.dart';

class CategoryViewScreen extends StatelessWidget {
  const CategoryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    final String? category = args?['category'];
    final List<String>? subcategories =
    (args?['subcategories'] as List?)?.cast<String>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.viewCategory,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your category",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.green500,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: category ?? 'No category available',
              enabled: false,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Subcategories",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.green500,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (subcategories != null && subcategories.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: subcategories.map((subcategory) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, size: 16, color: Colors.black),
                        const SizedBox(width: 4),
                        Text(subcategory),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              const Text(
                "No subcategories available.",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}

