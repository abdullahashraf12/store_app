abstract class ApiUrls {
  static String ip = "192.168.1.11";
  static String port = "8080";
  static String getAllProductsUrl = "http://" + ip + ":" + port + "/mobApi/a_p";
  static String getAllCategoriesUrl =
      "http://" + ip + ":" + port + "/mobApi/a_c";
  static String getAllVendorsUrl = "http://" + ip + ":" + port + "/mobApi/a_v";
  static String getAllProductByIDsUrl =
      "http://" + ip + ":" + port + "/mobApi/a_p/";
  static String getAllCategoriesByIDsUrl =
      "http://" + ip + ":" + port + "/mobApi/a_c/";
  static String getAllVendorsByIDsUrl =
      "http://" + ip + ":" + port + "/mobApi/a_v/";
  static String variable_categ = "";
  static String variable_prod = "";

  static String SearchProduct = "http://" +
      ip +
      ":" +
      port +
      "/mobApi/get_p_n_c/" +
      "?category_category=" +
      variable_categ +
      "&search_name=" +
      variable_prod;
}
