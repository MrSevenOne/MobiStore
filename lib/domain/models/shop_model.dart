class ShopModel {
  final int? id;
  final DateTime? createdAt;
  final String address;
  final String storeName;
  final String? userId;

  ShopModel({
    this.id,
    this.createdAt,
    required this.address,
    required this.storeName,
    this.userId,
  });

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
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

    /// copyWith metodi
  ShopModel copyWith({
    int? id,
    String? name,
    String? address,
    String? userId,
    DateTime? createdAt,
  }) {
    return ShopModel(
      id: id ?? this.id,
      storeName: name ?? this.storeName,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
