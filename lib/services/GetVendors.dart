import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/VendorsM.dart';

class VendorService {
  final Dio _dio = Dio();

  Future<List<VendorModel>> GetAllVendors() async {
    try {
      Response response = await _dio.get(ApiUrls.getAllVendorsUrl);
      List<dynamic> data = response.data;
      return data.map((json) => VendorModel.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load products');
    }
  }
}
