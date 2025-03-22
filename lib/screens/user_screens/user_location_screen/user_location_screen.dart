import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_image_path.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';

class UserLocationScreen extends StatelessWidget {
  const UserLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 46),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImagePath.mapImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonWidget(
                onPressed: () {},
                label: AppStrings.trackMyLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
