import 'dart:io';

import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/profile_model.dart';
import '../../../utils/app_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class ProfileRepository {
  Future<Profile?> fetchProfile() async {
    try {
      var response = await ApiService.getApi(ApiUrls.profile);
      if (response.body["data"] != null && response.body["data"] is Map) {
        return Profile.fromJson(response.body["data"]);
      }
      return null;
    } catch (e) {
      errorLog(
        e,
        source: "fetchProfile repo function",
      );
      return null;
    }
  }

  Future<bool> updateProfile({
    String? name, // Optional
    List<double>? location, // Optional
    File? imageFile, // Optional
  }) async {
    try {
      // Prepare FormData dynamically
      final Map<String, dynamic> data = {};
      if (name != null && name.trim().isNotEmpty) {
        data["name"] = name;
      }
      if (location != null && location.isNotEmpty) {
        data["location"] = {"type": "Point", "coordinates": location};
      }
      if (imageFile != null) {
        data["image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: "profile.jpg",
          contentType: MediaType("image", "jpg"),
        );
      }

      FormData formData = FormData.fromMap(data);

      // Log FormData for debugging
      errorLog(
        formData.fields,
        source: "FormData being sent",
      );

      // Send the PATCH request
      var response = await ApiService.patchApi(
        ApiUrls.updateProfile,
        body: formData,
      );

      if (response != null) {
        AppSnackBar.success("Profile updated successfully.");
        return true;
      } else {
        AppSnackBar.error("Failed to update profile.");
        return false;
      }
    } catch (e) {
      errorLog(
        e,
        source: "updateProfile error",
      );
      AppSnackBar.error("An error occurred while updating the profile.");
      return false;
    }
  }
}
