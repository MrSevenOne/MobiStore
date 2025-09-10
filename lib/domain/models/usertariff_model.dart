import 'package:mobi_store/domain/models/tariffs_model.dart';
import 'package:mobi_store/export.dart';

class UserTariffModel {
  final int? id;
  final DateTime? createdAt;
  final String userId;
  final String? tariffId;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final TariffModel? tariff;

  UserTariffModel({
    this.id,
    this.createdAt,
    required this.userId,
    this.tariffId,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.tariff,
  });

  factory UserTariffModel.fromMap(Map<String, dynamic> map) {
    return UserTariffModel(
      id: map['id'] as int?,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      userId: map['user_id'] as String,
      tariffId: map['tariff_id'] as String?,
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      isActive: map['is_active'] as bool,
      tariff: TariffModel.fromMap(
        map['tariffs'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    final data = {
      'user_id': userId, // UUID bo'lishi kerak
      if (tariffId != null)
        'tariff_id': tariffId, // Null bo'lsa, default generatsiya qilinsin
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
    };

    debugPrint("📦 UserTariffModel.toMap() => $data");
    return data;
  }
}
