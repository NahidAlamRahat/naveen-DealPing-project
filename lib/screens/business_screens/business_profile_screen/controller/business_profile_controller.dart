import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:get/get.dart';

import '../../../../models/profile_model.dart';
import '../../../../services/repository/profile_repository/profile_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class BusinessProfileController extends GetxController {
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
        LocalStorage.userId = profile.value?.sId ?? '';
        LocalStorage.businessId = profile.value?.sId ?? '';
        appLog('business id ===>>> ${ LocalStorage.userId} ');

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
