class StoreModel {
  final int? id;
  final DateTime? createdAt;
  final String address;
  final String storeName;
  final String? userId;

  StoreModel({
    this.id,
    this.createdAt,
    required this.address,
    required this.storeName,
    this.userId,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as int?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      address: map['address'] ?? '',
      storeName: map['store_name'] ?? '',
      userId: map['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'address': address,
      'store_name': storeName,
      'user_id': userId,
    };
  }
}
