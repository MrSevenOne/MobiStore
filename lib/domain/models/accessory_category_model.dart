class AccessoryCategoryModel {
  final String id;
  final String name;

  AccessoryCategoryModel({
    required this.id,
    required this.name,
  });

  factory AccessoryCategoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
