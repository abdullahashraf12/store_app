class CategoryModel {
  final int id;
  final String cid;
  final String title;
  final String image;

  CategoryModel({
    required this.id,
    required this.cid,
    required this.title,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      cid: json['cid'],
      title: json['title'],
      image: json['image'],
    );
  }
}
