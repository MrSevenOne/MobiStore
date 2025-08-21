import 'package:mobi_store/domain/models/company_model.dart';

class PhoneReportModel {
  final int id;
  final DateTime createdAt;
  final String companyName;
  final String modelName;
  final String? colour;
  final int? yomkist;
  final String status;
  final bool box;
  final int imei;
  final double price;
  final String? userId;
  final String shopId;
  final String? imageUrl;
  final String? fileId;
  final int? ram;
  final int memory;
  final double salePrice;
  final DateTime saleTime;
  final int paymentType; 
  final CompanyModel? companyModel;

  PhoneReportModel({
    required this.id,
    required this.createdAt,
    required this.companyName,
    required this.modelName,
    this.colour,
    this.yomkist,
    required this.status,
    required this.box,
    required this.imei,
    required this.price,
    this.userId,
    required this.shopId,
    this.imageUrl,
    this.fileId,
    this.ram,
    required this.memory,
    required this.salePrice,
    required this.saleTime,
    required this.paymentType, 
    this.companyModel,
  });

  factory PhoneReportModel.fromJson(Map<String, dynamic> json) {
    return PhoneReportModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      companyName: json['company_name'] as String,
      modelName: json['model_name'] as String,
      colour: json['colour'],
      yomkist: json['yomkist'],
      status: json['status'],
      box: json['box'],
      imei: json['imei'],
      price: (json['price'] as num).toDouble(),
      userId: json['user_id'],
      shopId: json['shop_id'],
      imageUrl: json['image_url'],
      fileId: json['file_id'],
      ram: json['ram'],
      memory: json['memory'],
      salePrice: (json['sale_price'] as num).toDouble(),
      saleTime: DateTime.parse(json['sale_time']),
      paymentType: json['payment_type'] as int,
      companyModel: json['company'] != null
            ? CompanyModel.fromJson(json['company'])
            : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'company_name': companyName,
      'model_name': modelName,
      'colour': colour,
      'yomkist': yomkist,
      'status': status,
      'box': box,
      'imei': imei,
      'price': price,
      'user_id': userId,
      'shop_id': shopId,
      'image_url': imageUrl,
      'file_id': fileId,
      'ram': ram,
      'memory': memory,
      'sale_price': salePrice,
      'sale_time': saleTime.toIso8601String(),
      'payment_type': paymentType, 
    };
  }
}
