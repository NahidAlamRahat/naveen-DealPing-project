import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final Widget? textWidget;

  final Widget? action;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle; // Add centerTitle property
  final Color? backgroundColor;
  final Widget? leading;
  final bool showLeading;

  const AppbarWidget({
    super.key,
     this.text,
    this.textWidget,
    this.action,
    this.bottom,
    this.centerTitle, // Add centerTitle to constructor
    this.backgroundColor,
    this.leading,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: Container(color: backgroundColor ?? AppColors.white),
      //titleSpacing: showLeading ? 1 : -35,
      leading: showLeading
          ? (leading ??
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.green500,
                  size: 20,
                ),
              ))
          : Container(),
      titleSpacing: -4,
      actions: action != null ? [action!] : null,
      title:textWidget ?? Text(
        text ?? "",
        style: TextStyle(
          fontSize: ResponsiveUtils.width(20),
          fontWeight: FontWeight.w500,
          color: AppColors.green500,
        ),
      ),
      bottom: bottom,
      // Add bottom to AppBar
      centerTitle: centerTitle, // Set centerTitle in AppBar
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
