import 'package:deal_ping/services/api/api_services.dart';

import '../../../constants/api_urls.dart';
import '../../../models/category_model.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserHomeRepository {
  Future<List<Category>> fetchCategories() async {
    List<Category> listOfData = <Category>[];
    try {
      final response = await ApiService.getApi(
        ApiUrls.categories
      );

      // return Category.fromJson(response.body);
if(response.statusCode == 200){
  if(response.body["data"] != null && response.body["data"] is List) {
    for (var item in response.body["data"]) {
      listOfData.add(Category.fromJson(item));
    }
  }
}
        } catch (e) {
      AppSnackBar.error("An error occurred while fetching categories.");

    }
    return listOfData;
  }
}
