class ProductsModel {
  final int id;
  final String pid;
  final String title;
  final String image;
  final String backImage;
  final String description;
  final int userId;
  final int categoryId;
  final int vendorId;
  final String price;
  final String oldPrice;
  final String specification;
  final int tagsId;
  final String productsStatus;
  final bool status;
  final bool inStock;
  final bool digital;
  final bool featured;
  final String sku;
  final DateTime date;
  final DateTime update;

  ProductsModel({
    required this.id,
    required this.pid,
    required this.title,
    required this.image,
    required this.backImage,
    required this.description,
    required this.userId,
    required this.categoryId,
    required this.vendorId,
    required this.price,
    required this.oldPrice,
    required this.specification,
    required this.tagsId,
    required this.productsStatus,
    required this.status,
    required this.inStock,
    required this.digital,
    required this.featured,
    required this.sku,
    required this.date,
    required this.update,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    print(json['title']);
    return ProductsModel(
      id: json['id'],
      pid: json['pid'],
      title: json['title'],
      image: json['image'],
      backImage: json['back_image'],
      description: json['description'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      vendorId: json['vendor_id'],
      price: json['price'],
      oldPrice: json['old_Price'],
      specification: json['spescification'],
      tagsId: json['tags_id'],
      productsStatus: json['products_status'],
      status: json['status'],
      inStock: json['in_stock'],
      digital: json['digital'],
      featured: json['featured'],
      sku: json['sku'],
      date: DateTime.parse(json['date']),
      update: DateTime.parse(json['update']),
    );
  }
}
