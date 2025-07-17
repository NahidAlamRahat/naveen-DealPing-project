import 'package:deal_ping/screens/faq_screen/widgets/faq_item.dart';
import 'package:deal_ping/utils/capitalize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import 'controller/faq_screen_controller.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FAQScreenController controller = Get.put(FAQScreenController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.faq,
        centerTitle: true,
      ),
    /*  body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.faqs.isEmpty) {
          return const Center(
            child: TextWidget(
              text: "No FAQs available.",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.faqs.length,
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return FAQItem(
              question:
                  "${index.bitLength + 1}. ${capitalize(faq.question ?? "No question available")}",
              answer: capitalize(faq.answer ?? "No answer available"),
            );
          },
        );
      }),
*/

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.faqs.isEmpty) {
          return const Center(child: Text('No FAQs available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.faqs.length,
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return FAQItem(
              question:
              "${index.bitLength + 1}. ${capitalize(faq.question ?? "No question available")}",
              answer: capitalize(faq.answer ?? "No answer available"),
            );
          },
        );
      }),


    );
  }
}
