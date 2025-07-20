import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_app_entry.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set UI settings
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize GetStorage before running the app
  await LocalStorage.getAllPrefData();

  // Run the main app
  runApp(const MainApp());
}
