import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/ProductM.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<ProductsModel>> getAllProducts() async {
    try {
      Response response = await _dio.get(ApiUrls.getAllProductsUrl);
      List<dynamic> data = response.data;
      return data.map((json) => ProductsModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load products');
    }
  }
}
