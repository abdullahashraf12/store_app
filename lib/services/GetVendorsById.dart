import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';
import 'package:store_app/models/VendorsM.dart';

class VendorService {
  final Dio _dio = Dio();

  Future<VendorModel> getVendorById(String vendorId) async {
    try {
      Response response =
          await _dio.get(ApiUrls.getAllVendorsByIDsUrl(vendorId));
      return VendorModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to load vendor');
    }
  }
}
