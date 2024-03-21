class VendorModel {
  final int id;
  final String vid;
  final String title;
  final String image;
  final String description;
  final String address;
  final String contact;
  final String chatRespTime;
  final String shippingRespTime;
  final String authenticRating;
  final String daysReturn;
  final String warrantyPeriod;
  final int userId;

  VendorModel({
    required this.id,
    required this.vid,
    required this.title,
    required this.image,
    required this.description,
    required this.address,
    required this.contact,
    required this.chatRespTime,
    required this.shippingRespTime,
    required this.authenticRating,
    required this.daysReturn,
    required this.warrantyPeriod,
    required this.userId,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      vid: json['vid'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      address: json['address'],
      contact: json['contact'],
      chatRespTime: json['chat_resp_time'],
      shippingRespTime: json['shipping_resp_time'],
      authenticRating: json['Authentic_rating'],
      daysReturn: json['days_return'],
      warrantyPeriod: json['warrantly_period'],
      userId: json['user_id'],
    );
  }
}
