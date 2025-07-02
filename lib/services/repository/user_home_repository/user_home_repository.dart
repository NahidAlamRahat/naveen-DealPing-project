import 'package:deal_ping/services/api/api_services.dart';

import '../../../constants/api_urls.dart';
import '../../../models/category_model.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserHomeRepository {
  Future<Category?> fetchCategories() async {
    try {
      final response = await ApiService.getApi(
        ApiUrls.categories,
      );
      if (response != null) {
        return Category.fromJson(response.body);
      } else {
        AppSnackBar.error("Failed to fetch categories.");
        return null;
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while fetching categories.");
      return null;
    }
  }
}
