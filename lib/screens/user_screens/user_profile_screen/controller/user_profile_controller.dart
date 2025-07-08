import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:get/get.dart';

import '../../../../models/profile_model.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  var profile = Rxn<Profile>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

   fetchUserProfile() async {
    isLoading.value = true;
    try {

      var fetchedProfile = await _profileRepository.fetchProfile();
      print('fetchProfile ==> $fetchedProfile');
      if (fetchedProfile != null) {
        profile.value = fetchedProfile;
      } else {
        AppSnackBar.error("Failed to load profile data.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while fetching profile data.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      AppSnackBar.success("Logged out successfully!");
      LocalStorage.removeAllPrefData();
    } catch (e) {
      AppSnackBar.error("Failed to log out. Please try again.");
    }
  }
}
