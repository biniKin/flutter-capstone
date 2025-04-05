class ProductModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String imageUrl;
  double rate;
  double count;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rate,
    required this.count,
  });

  //converting Json to Object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image'] ?? '',
      rate: json['rate'] ?? 0,
      count: json['count'] ?? 0,
    );
  }
  //converting obj to json format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': imageUrl,
      'rate': rate,
      'count': count,
    };
  }
}
