class AccessoryModel {
  final String id;
  final String name;
  final int price;
  final String? categoryId;
  final String? brand;
  final String? colour;
  final String? imageUrl;
  final DateTime createdAt;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.price,
    this.categoryId,
    this.brand,
    this.colour,
    this.imageUrl,
    required this.createdAt,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      categoryId: json['category_id'] as String?,
      brand: json['brand'] as String?,
      colour: json['colour'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category_id': categoryId,
      'brand': brand,
      'colour': colour,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
