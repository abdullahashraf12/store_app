import 'package:dio/dio.dart';
import 'package:store_app/models/ProductM.dart';
import 'package:store_app/models/VendorsM.dart';
import 'package:store_app/constants/API_URLS.dart';

class DataService {
  final Dio _dio = Dio();

  Future<List<ProductsModel>> getAllProducts_search(
      String CategID, String ProdId) async {
    try {
      Response response =
          await _dio.get(ApiUrls.searchProductUrl(CategID, ProdId));
      List<dynamic> productsData = response.data['products'];
      return productsData.map((json) => ProductsModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load products');
    }
  }

  Future<List<VendorModel>> getAllVendors_search(
      String CategID, String ProdId) async {
    try {
      Response response =
          await _dio.get(ApiUrls.searchProductUrl(CategID, ProdId));
      List<dynamic> vendorsData = response.data['vendors'];
      return vendorsData.map((json) => VendorModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load vendors');
    }
  }
}
