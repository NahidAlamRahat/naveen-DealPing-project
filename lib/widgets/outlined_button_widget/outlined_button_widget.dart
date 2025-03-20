// import 'package:flutter/material.dart';
// import 'package:land_london/widgets/icon_widget/icon_widget.dart';
// import 'package:land_london/widgets/space_widget/space_widget.dart';
//
// import '../../constants/app_colors.dart';
// import '../../utils/app_size.dart';
//
// class OutlinedButtonWidget extends StatelessWidget {
//   final String label;
//   final String? icon;
//   final double? iconHeight;
//   final double? iconWidth;
//   final Color textColor;
//   final double fontSize;
//   final VoidCallback? onPressed;
//   final double buttonHeight;
//   final double buttonWidth;
//   final EdgeInsetsGeometry? padding;
//   final BorderRadiusGeometry buttonRadius;
//   final Color? backgroundColor;
//   final Color? borderColor;
//
//   const OutlinedButtonWidget({
//     super.key,
//     required this.label,
//     this.icon,
//     this.iconHeight,
//     this.iconWidth,
//     this.textColor = Colors.white,
//     this.fontSize = 16.0,
//     this.onPressed,
//     this.buttonHeight = 56,
//     this.buttonWidth = 200.0,
//     this.padding,
//     this.buttonRadius = const BorderRadius.all(Radius.circular(8)),
//     this.backgroundColor,
//     this.borderColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     ResponsiveUtils.initialize(context);
//     return Container(
//       height: ResponsiveUtils.height(buttonHeight),
//       width: ResponsiveUtils.width(buttonWidth),
//       decoration: BoxDecoration(
//         color: backgroundColor ?? AppColors.green500,
//         borderRadius: buttonRadius,
//         border: Border.all(
//           width: ResponsiveUtils.width(1),
//           color: borderColor ?? AppColors.black,
//         ),
//       ),
//       child: MaterialButton(
//         onPressed: onPressed,
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: ResponsiveUtils.width(fontSize),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SpaceWidget(spaceWidth: 8),
//             IconWidget(height: 20, width: 20, icon: icon!)
//           ],
//         ),
//       ),
//     );
//   }
// }
