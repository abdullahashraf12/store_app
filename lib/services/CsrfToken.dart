import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:store_app/constants/API_URLS.dart';

class Csrf {
  String? csrfToken;
  Dio dio = Dio();

  Future<String?> getCsrfToken() async {
    var response = await dio.get(ApiUrls.csrfUrl);
    csrfToken =
        response.headers.map['set-cookie']?.first.split(';')[0].split('=')[1];
    return csrfToken;
  }
}
