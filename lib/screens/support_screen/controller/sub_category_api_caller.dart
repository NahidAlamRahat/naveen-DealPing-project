
import 'package:deal_ping/screens/support_screen/model/support_category.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constants/api_urls.dart';
import '../../../../services/storage/storage_service.dart';

class SubCategoryApiController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  List<SupportSubCategoryModel> _subCategoryList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<SupportSubCategoryModel> get subCategoryList => _subCategoryList;

  Future<bool> getSubCategory() async {
    _isLoading = true;
    update();

    final response = await ApiService.getApi(
      ApiUrls.subCategories,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
      },
    );

    print("response status code ${response.statusCode}");

    bool isSuccess = false;

    if (response.statusCode == 200) {
      try {
        final List dataList = response.body['data'] as List;

        _subCategoryList = dataList
            .map((item) => SupportSubCategoryModel.fromJson(item))
            .toList();

        _errorMessage = null;
        isSuccess = true;

        debugPrint('✅ First subcategory title: ${_subCategoryList[0].title}');
      } catch (e) {
        _errorMessage = "Data parsing error: ${e.toString()}";
      }
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }


  Future<void> refreshSubCategory() async {
    _subCategoryList = [];
    await getSubCategory();
  }
}

