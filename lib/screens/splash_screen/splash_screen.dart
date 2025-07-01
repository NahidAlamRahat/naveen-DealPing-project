import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_image_path.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
     SplashController splashController = Get.put(SplashController());



    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,

      ),
      child: Scaffold(
        backgroundColor: AppColors.green500,
        body: Center(
          child: Image.asset(
            AppImagePath.appLogoWhite,
            height: 180,
            width: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
