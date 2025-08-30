import 'package:intl/intl.dart';
import 'package:mobi_store/domain/models/company_model.dart';

class PhoneModel {
  final int? id;
  final String modelName;
  final String? colour;
  final int? yomkist;
  final String status;
  final bool box;
  final int imei;
  final double buyPrice;
  final double CostPrice;
  final String? userId;
  final String shopId;
  final String? imageUrl;
  final String? fileId;
  final String companyName;
  final DateTime? createdAt;
  final CompanyModel? companyModel;
  final int memory;
  final int? ram;

  PhoneModel({
    this.id,
    required this.modelName,
    this.colour,
    this.yomkist,
    required this.status,
    required this.box,
    required this.imei,
    required this.buyPrice,
    required this.CostPrice,
    this.userId,
    required this.shopId,
    this.imageUrl,
    this.fileId,
    required this.companyName,
    this.createdAt,
    this.companyModel,
    required this.memory,
    this.ram,
  });

  // Getterlar
  String get buyPriceFormatted {
    final formatter = NumberFormat.decimalPattern('uz_UZ');
    return formatter.format(buyPrice);
  }

  String get costPriceFormatted {
    final formatter = NumberFormat.decimalPattern('uz_UZ');
    return formatter.format(CostPrice);
  }

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        id: json['id'],
        modelName: json['model_name'],
        colour: json['colour'],
        yomkist: json['yomkist'],
        status: json['status'],
        box: json['box'],
        imei: json['imei'],
        buyPrice: (json['buy_price'] as num).toDouble(),
        CostPrice: (json['cost_price'] as num).toDouble(),
        userId: json['user_id'],
        shopId: json['shop_id'],
        imageUrl: json['image_url'],
        fileId: json['file_id'],
        companyName: json['company_name'],
        memory: json['memory'],
        ram: json['ram'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        companyModel: json['company'] != null
            ? CompanyModel.fromJson(json['company'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        // 'id': id, // Yangilash uchun id qo‘shildi
        'model_name': modelName,
        'colour': colour,
        'yomkist': yomkist,
        'status': status,
        'box': box,
        'imei': imei,
        'buy_price': buyPrice,
        'cost_price': CostPrice,
        'shop_id': shopId,
        'image_url': imageUrl,
        'file_id': fileId,
        'company_name': companyName,
        'memory': memory,
        'ram': ram,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          modelName == other.modelName &&
          colour == other.colour &&
          yomkist == other.yomkist &&
          status == other.status &&
          box == other.box &&
          imei == other.imei &&
          buyPrice == other.buyPrice &&
          CostPrice == other.CostPrice &&
          userId == other.userId &&
          shopId == other.shopId &&
          imageUrl == other.imageUrl &&
          fileId == other.fileId &&
          companyName == other.companyName &&
          createdAt == other.createdAt &&
          companyModel == other.companyModel &&
          memory == other.memory &&
          ram == other.ram;

  @override
  int get hashCode => Object.hash(
        id,
        modelName,
        colour,
        yomkist,
        status,
        box,
        imei,
        buyPrice,
        CostPrice,
        userId,
        shopId,
        imageUrl,
        fileId,
        companyName,
        createdAt,
        companyModel,
        memory,
        ram,
      );
}
