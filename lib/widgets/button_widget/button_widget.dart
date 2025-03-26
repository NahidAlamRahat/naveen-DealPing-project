import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final String? icon;
  final double? iconHeight;
  final double? iconWidth;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final double buttonHeight;
  final double buttonWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry buttonRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final FontWeight? fontWeight;

  const ButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.iconHeight,
    this.iconWidth,
    this.textColor = AppColors.white,
    this.fontSize = 16,
    this.onPressed,
    this.buttonHeight = 52,
    this.buttonWidth = 339,
    this.padding,
    this.buttonRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor,
    this.borderColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Container(
      height: ResponsiveUtils.height(buttonHeight),
      width: ResponsiveUtils.width(buttonWidth),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.green500,
        borderRadius: buttonRadius,
        // border: Border.all(color: borderColor ?? AppColors.black, width: 1),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: ResponsiveUtils.width(fontSize),
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
