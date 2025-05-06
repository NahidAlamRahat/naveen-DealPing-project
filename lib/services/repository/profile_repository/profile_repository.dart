import 'package:deal_ping/constants/api_urls.dart';

import '../../../models/profile_model.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../api/api_get_services.dart';

class ProfileRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

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
}
