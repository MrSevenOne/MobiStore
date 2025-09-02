import 'package:equatable/equatable.dart';
import 'accessory_model.dart';

class AccessoryReportModel extends Equatable {
  final String? id;
  final String accessoryId;
  final int salePrice;
  final int saleQuantity;
  final String paymentType;
  final DateTime saleTime;
  final String? userId;
  final int storeId;

  // Bog'langan AccessoryModel
  final AccessoryModel? accessory;

  const AccessoryReportModel({
    this.id,
    required this.accessoryId,
    required this.salePrice,
    required this.saleQuantity,
    required this.paymentType,
    required this.saleTime,
    this.userId,
    required this.storeId,
    this.accessory,
  });

  factory AccessoryReportModel.fromMap(Map<String, dynamic> map) {
    return AccessoryReportModel(
      id: map['id'] as String?,
      accessoryId: map['accessory_id'] as String,
      salePrice: map['sale_price'] as int,
      saleQuantity: map['sale_quantity'] as int,
      paymentType: map['payment_type'] as String,
      saleTime: DateTime.parse(map['sale_time'] as String),
      userId: map['user_id'] as String?,
      storeId: map['store_id'] as int,
      accessory: map['accessory'] != null
          ? AccessoryModel.fromJson(Map<String, dynamic>.from(map['accessory']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'accessory_id': accessoryId,
      'sale_price': salePrice,
      'sale_quantity': saleQuantity,
      'payment_type': paymentType,
      'sale_time': saleTime.toIso8601String(),
      'store_id': storeId,
      'user_id': userId,
    };

    if (accessory != null) {
      map['accessory'] = accessory!.toJson();
    }

    return map;
  }

  @override
  List<Object?> get props => [
        id,
        accessoryId,
        salePrice,
        saleQuantity,
        paymentType,
        saleTime,
        userId,
        storeId,
        accessory,
      ];
}
