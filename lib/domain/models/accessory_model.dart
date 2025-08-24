class AccessoryModel {
  final String id;
  final String name;
  final int price;
  final String? categoryId;
  final String? brand;
  final String? colour;
  final String? imageUrl;
  final DateTime createdAt;
  final int storeId;
  final String userId;
  final int quantity;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.price,
    this.categoryId,
    this.brand,
    this.colour,
    this.imageUrl,
    required this.createdAt,
    required this.storeId,
    required this.userId,
    required this.quantity,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      categoryId: json['category_id'],
      brand: json['brand'],
      colour: json['colour'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      storeId: json['store_id'] as int,
      userId: json['user_id'] as String,
      quantity: json['quantity'] as int,
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
      'store_id': storeId,
      'user_id': userId,
      'quantity': quantity,
    };
  }
}
