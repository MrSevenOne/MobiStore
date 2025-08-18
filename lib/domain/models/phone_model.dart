import 'package:mobi_store/domain/models/company_model.dart';

class PhoneModel {
  final int? id;
  final String modelName;
  final String? colour;
  final int? yomkist;
  final String status;
  final bool box;
  final int imei;
  final double price;
  final String? userId;
  final String shopId;
  final String imageUrl;
  final String? fileId; // 🔥 ImageKit fileId qo‘shildi
  final String companyName; // uuid
  final DateTime? createdAt;
  final CompanyModel? companyModel;

  PhoneModel({
    this.id,
    required this.modelName,
    this.colour,
    this.yomkist,
    required this.status,
    required this.box,
    required this.imei,
    required this.price,
    this.userId,
    required this.shopId,
    required this.imageUrl,
    this.fileId, // 🔥
    required this.companyName,
    this.createdAt,
    this.companyModel,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        id: json['id'],
        modelName: json['model_name'],
        colour: json['colour'],
        yomkist: json['yomkist'],
        status: json['status'],
        box: json['box'],
        imei: json['imei'],
        price: (json['price'] as num).toDouble(),
        userId: json['user_id'],
        shopId: json['shop_id'],
        imageUrl: json['image_url'],
        fileId: json['file_id'], // 🔥 JSON’dan olish
        companyName: json['company_name'], // uuid yoki name
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        companyModel: json['company'] != null
            ? CompanyModel.fromJson(json['company'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'model_name': modelName,
        'colour': colour,
        'yomkist': yomkist,
        'status': status,
        'box': box,
        'imei': imei,
        'price': price,
        'shop_id': shopId,
        'image_url': imageUrl,
        'file_id': fileId, // 🔥 Supabase’ga ham saqlanadi
        'company_name': companyName,
      };
}
