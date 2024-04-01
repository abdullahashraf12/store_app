class ApiUrls {
  static const String ip = "192.168.1.8";
  static const String port = "8080";
  static const String fullUrl = "http://$ip:$port";
  static const String getAllProductsUrl = "http://$ip:$port/mobApi/a_p";
  static const String getAllCategoriesUrl = "http://$ip:$port/mobApi/a_c";
  static const String getAllVendorsUrl = "http://$ip:$port/mobApi/a_v";

  static String getAllProductByIDsUrl(String productId) =>
      "http://$ip:$port/mobApi/a_p/$productId";

  static String getAllCategoriesByIDsUrl(String categoryId) =>
      "http://$ip:$port/mobApi/a_c/$categoryId";

  static String getAllVendorsByIDsUrl(String vendorId) =>
      "http://$ip:$port/mobApi/a_v/$vendorId";

  static String searchProductUrl(String category, String productName) =>
      "http://$ip:$port/mobApi/get_p_n_c/?category_category=$category&search_name=$productName";
  static const String csrfUrl = 'http://$ip:$port/mobApi/get-csrf-token/';
  static const String loginUrl = 'http://$ip:$port/mobApi/login_user_mob/';
  static const String logoutUrl = 'http://$ip:$port/mobApi/logout_mob/';
  static const String WebSocketUrl = "ws://$ip:$port/ws/socket-server/";
  static const String WebSocketNotificationUrl =
      "ws://$ip:$port/ws/socket-server/token";
}
