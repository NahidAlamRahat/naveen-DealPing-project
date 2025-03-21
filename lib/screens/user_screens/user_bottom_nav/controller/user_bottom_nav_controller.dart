import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
