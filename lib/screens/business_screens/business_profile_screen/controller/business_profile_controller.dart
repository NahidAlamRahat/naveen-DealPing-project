import 'package:get/get.dart';

import '../../../../models/profile_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../services/storage_services/app_auth_storage.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessProfileController extends GetxController {
  AppAuthStorage appAuthStorage = AppAuthStorage();
  final ProfileRepository _profileRepository = ProfileRepository();
  var profile = Rxn<Profile>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    isLoading.value = true;
    try {
      var fetchedProfile = await _profileRepository.fetchProfile();
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
      await appAuthStorage.storageClear();
      AppSnackBar.success("Logged out successfully!");
      Get.offAllNamed(AppRoutes.userSigninScreen);
    } catch (e) {
      AppSnackBar.error("Failed to log out. Please try again.");
    }
  }
}
