import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app_colors.dart';

class AppSnackBar {
  static error(String parameterValue, {int seconds = 2}) {
    Fluttertoast.showToast(
      msg: "Error! $parameterValue",
      toastLength: seconds > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: seconds,
      backgroundColor: Colors.red,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static success(String parameterValue, {int seconds = 2}) {
    Fluttertoast.showToast(
      msg: parameterValue,
      toastLength: seconds > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: seconds,
      backgroundColor: Colors.green,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static message(
    String parameterValue, {
    Color backgroundColor = AppColors.grey,
    Color color = AppColors.white,
    int seconds = 2,
  }) {
    Fluttertoast.showToast(
      msg: parameterValue,
      toastLength: seconds > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: seconds,
      backgroundColor: backgroundColor,
      textColor: color,
      fontSize: 16.0,
    );
  }
}
