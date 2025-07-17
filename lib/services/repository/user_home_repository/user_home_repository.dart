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
      print("response ==> ${response.body}");
      return Category.fromJson(response.body);
        } catch (e) {
      AppSnackBar.error("An error occurred while fetching categories.");
      return null;
    }
  }
}
