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
     /* body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text:
                    'Welcome to DealPing, your go-to platform for discovering and booking top-notch services in your area. Whether you’re looking for a great restaurant, a relaxing spa, a fitness class, or a salon appointment, we’ve got you covered—all at the tip of your fingers!',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 16),
              TextWidget(
                text:
                    '• Instant Access to a wide range of services: Restaurants, Salons, Spas, Fitness, and more!',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 8),
              TextWidget(
                text:
                    '• Exclusive Deals & Offers to help you save while enjoying the best experiences.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 8),
              TextWidget(
                text:
                    '• Quick & Easy Booking: Reserve your table, book an appointment, or schedule a service instantly.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 8),
              TextWidget(
                text:
                    '• Personalized Recommendations based on your preference and location.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 8),
              TextWidget(
                text:
                    '• Verified Providers: We partner with the best in the industry to ensure top-quality service.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
              SizedBox(height: 16),
              TextWidget(
                text:
                    'DealPing makes it simple for you to find what you need, when you need it, all from the convenience of your mobile device.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.grey300,
                textAlignment: TextAlign.start,
              ),
            ],
          ),
        ),
      ),*/

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.termsConditions.value.data == null) {
          return const Center(child: Text('No About Us available'));
        }
        final termsContent =
            controller.termsConditions.value.data!.content ?? '';
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
