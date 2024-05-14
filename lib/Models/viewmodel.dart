class Products {
  final int id;
  final String name;
  final String image;
  final int price;
  final String createdDate;
  final String createdTime;
  final String modifiedDate;
  final String modifiedTime;
  final bool flag;

  Products({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdDate,
    required this.createdTime,
    required this.modifiedDate,
    required this.modifiedTime,
    required this.flag,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      createdDate: json['created_date'],
      createdTime: json['created_time'],
      modifiedDate: json['modified_date'],
      modifiedTime: json['modified_time'],
      flag: json['flag'],
    );
  }
}
