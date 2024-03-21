import 'package:dio/dio.dart';
import 'package:store_app/models/CategoriesM.dart';
import 'package:store_app/constants/API_URLS.dart';

class CategoryService {
  final Dio _dio = Dio();

  Future<List<CategoryModel>> GetAllVendors() async {
    try {
      Response response = await _dio.get(ApiUrls.getAllVendorsUrl);
      List<dynamic> data = response.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load products');
    }
  }
}
