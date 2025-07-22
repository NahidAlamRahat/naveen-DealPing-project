
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

// class SupportCategory {
//   final String id;
//   final String title;
//
//   SupportCategory({
//     required this.id,
//     required this.title,
//   });
//
//   factory SupportCategory.fromJson(Map<String, dynamic> json) {
//     return SupportCategory(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'title': title,
//   };
// }


// class SupportFormSection {
//   RxString selectedType = ''.obs;
//   TextEditingController problemController = TextEditingController();
// }

// class SupportFormSection {
//   final int id;
//   RxString selectedType;
//   RxString selectedCategory;
//   RxList<String> selectedSubCategories;
//   TextEditingController problemController;
//
//   SupportFormSection({
//     required this.id,
//     required this.selectedType,
//     required this.selectedCategory,
//     required this.selectedSubCategories,
//     required this.problemController,
//   });
// }





// MODEL CODE - support_category.dart

class SupportCategory {
  final String id;
  final String title;
  final List<String> subCategories;

  SupportCategory({required this.id, required this.title, required this.subCategories});

  factory SupportCategory.fromJson(Map<String, dynamic> json) {
    return SupportCategory(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subCategories: List<String>.from(json['subCategories'] ?? []),
    );
  }
}



class SupportSubCategoryModel {
  final String id;
  final String title;

  const SupportSubCategoryModel({
    required this.id,
    required this.title,
  });

  factory SupportSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SupportSubCategoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }

  @override
  String toString() {
    return 'SupportSubCategoryModel(id: $id, title: $title)';
  }
}
