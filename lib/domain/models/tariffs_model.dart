import 'package:equatable/equatable.dart';

class TariffModel extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final String name;
  final int price;
  final int durationDays;
  final String? description;
  final int storeAmount;
  final bool accessory;

  const TariffModel({
    this.id,
    this.createdAt,
    required this.name,
    required this.price,
    required this.durationDays,
    this.description,
    required this.storeAmount,
    required this.accessory,
  });

  factory TariffModel.fromMap(Map<String, dynamic> map) {
    return TariffModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      durationDays: map['duration_days'] ?? 0,
      description: map['description'],
      storeAmount: map['store_amount'] ?? 0,
      accessory: map['accessory'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'duration_days': durationDays,
      'description': description,
      'store_amount': storeAmount,
      'accessory': accessory,
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        name,
        price,
        durationDays,
        description,
        storeAmount,
        accessory,
      ];
}
