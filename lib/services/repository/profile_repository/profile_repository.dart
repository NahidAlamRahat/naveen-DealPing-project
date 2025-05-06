import 'dart:io';

import 'package:deal_ping/constants/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/profile_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../api/api_get_services.dart';
import '../../api/api_patch_services.dart';

class ProfileRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();
  final ApiPatchServices _apiPatchServices = ApiPatchServices();

  Future<Profile?> fetchProfile() async {
    try {
      var response = await _apiGetServices.apiGetServices(ApiUrls.profile);
      if (response != null) {
        return Profile.fromJson(response);
      }
      return null;
    } catch (e) {
      errorLog("fetchProfile repo function", e);
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
      errorLog("FormData being sent", formData.fields);

      // Send the PATCH request
      var response = await _apiPatchServices.apiPatchServices(
        url: ApiUrls.updateProfile,
        body: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response != null) {
        AppSnackBar.success("Profile updated successfully.");
        return true;
      } else {
        AppSnackBar.error("Failed to update profile.");
        return false;
      }
    } catch (e) {
      errorLog("updateProfile error", e);
      AppSnackBar.error("An error occurred while updating the profile.");
      return false;
    }
  }
}
