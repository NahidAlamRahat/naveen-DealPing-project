import '../../../constants/api_urls.dart';
import '../../../models/category_model.dart';
import '../../../services/api/api_get_services.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserHomeRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<Category?> fetchCategories() async {
    try {
      final response = await _apiGetServices.apiGetServices(
        ApiUrls.baseUrl + ApiUrls.categories,
      );
      if (response != null) {
        return Category.fromJson(response);
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
