import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';

import 'package:store_app/models/ProductM.dart';

class ProductServiceWithId {
  final Dio _dio = Dio();

  Future<ProductsModel> getProductById(String productId) async {
    try {
      Response response =
          await _dio.get(ApiUrls.getAllProductByIDsUrl(productId));
      return ProductsModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to load product');
    }
  }
}
