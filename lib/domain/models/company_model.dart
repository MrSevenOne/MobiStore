class CompanyModel {
  final String? id;
  final String name;
  final DateTime? createdAt;

  CompanyModel({
    this.id,
    required this.name,
    this.createdAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
      };
}
