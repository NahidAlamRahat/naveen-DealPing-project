import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../utils/app_size.dart';

class OtpInputFieldWidget extends StatelessWidget {
  const OtpInputFieldWidget({
    super.key,
    this.isLast = false,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
    this.borderColor = AppColors.grey500,
    this.controller,
    this.onFieldSubmitted,
  });

  final bool isLast;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color borderColor;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ResponsiveUtils.width(5)),
      height: ResponsiveUtils.height(60),
      width: ResponsiveUtils.width(50),
      child: Center(
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "";
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          textInputAction: textInputAction,
          onChanged: (value) {
            if (value.isNotEmpty && !isLast) {
              FocusManager.instance.primaryFocus?.nextFocus();
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
              isDense: true,
              constraints: BoxConstraints(
                maxHeight: ResponsiveUtils.width(50),
                maxWidth: ResponsiveUtils.width(48),
              ),
              filled: true,
              fillColor: fillColor ?? AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: const BorderSide(color: AppColors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ResponsiveUtils.width(8)),
                borderSide: const BorderSide(color: AppColors.red, width: 1),
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0)),
        ),
      ),
    );
  }
}
