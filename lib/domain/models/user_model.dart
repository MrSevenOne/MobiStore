class UserModel {
  final String? id;
  final DateTime? createdAt;
  final String name;
  final String email;
  final String password;
  final bool? status;

  UserModel({
     this.id,
    this.createdAt,
    required this.name,
    required this.email,
    required this.password,
    this.status,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      status: map['status'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'status': status,
    };
  }

  /// Faqat insert/update uchun
  Map<String, dynamic> toInsertMap() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (password != null && password!.isNotEmpty) {
      map['password'] = password;
    }

    return map;
  }


  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? status,
  }) {
    return UserModel(
      id: id,
      createdAt: createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
