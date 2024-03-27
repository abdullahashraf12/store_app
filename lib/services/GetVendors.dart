import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/VendorsM.dart';

class VendorService {
  final Dio _dio = Dio();

  Future<List<VendorModel>> GetAllVendors() async {
    try {
      Response response = await _dio.get(ApiUrls.getAllVendorsUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => VendorModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load vendors: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Error fetching vendors: $error');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to load vendors: $error');
    }
  }
}
