import 'package:mobi_store/utils/formater/price_formater.dart';

class AccessoryModel {
  final String? id;
  final String name;
  final double buyPrice;   // jadvaldagi buy_price
  final String? categoryId;
  final String? brand;
  final String? colour;
  final String? imageUrl;
  final DateTime createdAt;
  final int storeId;
  final String userId;
  final int quantity;
  final double costPrice;  // jadvaldagi cost_price

  AccessoryModel({
    this.id,
    required this.name,
    required this.buyPrice,
    this.categoryId,
    this.brand,
    this.colour,
    this.imageUrl,
    required this.createdAt,
    required this.storeId,
    required this.userId,
    required this.quantity,
    required this.costPrice,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      buyPrice: (json['buy_price'] as num).toDouble(),
      categoryId: json['category_id'] as String?,
      brand: json['brand'] as String?,
      colour: json['colour'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      storeId: (json['store_id'] as num).toInt(),
      userId: json['user_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      costPrice: (json['cost_price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'buy_price': buyPrice,
      'category_id': categoryId,
      'brand': brand,
      'colour': colour,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'store_id': storeId,
      'user_id': userId,
      'quantity': quantity,
      'cost_price': costPrice,
    };
  }
}

/// Extension qo‘shib qo‘yamiz
extension AccessoryFormatter on AccessoryModel {
  String get formattedBuyPrice => PriceFormatter.formatNumber(buyPrice);
  String get formattedCostPrice => PriceFormatter.formatNumber(costPrice);
}
