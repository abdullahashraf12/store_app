import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';

import 'package:store_app/models/CategoriesM.dart';

class CategoryService {
  final Dio _dio = Dio();

  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      Response response =
          await _dio.get(ApiUrls.getAllCategoriesByIDsUrl + categoryId);
      return CategoryModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to load category');
    }
  }
}
