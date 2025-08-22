import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/screens/about_us_screen/controller/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../constants/app_strings.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});



  @override
  Widget build(BuildContext context) {

    AboutUsController controller = Get.put(AboutUsController());

    return  Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.aboutUs,
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.termsConditions.value.data == null) {
          return const Center(child: Text('No About Us available'));
        }
        final termsContent =
            controller.termsConditions.value.data?.content ?? '';
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: HtmlWidget(
            termsContent,
          ),
        );
      }),

    );
  }
}
