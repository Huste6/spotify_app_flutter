import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final int id;

  const UserModel({
    required this.name,
    required this.email,
    required this.id,
  });

  // Chuyển đối tượng thành Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
    };
  }

  // Tạo đối tượng từ Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  // Chuyển đối tượng thành JSON string
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ JSON string
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  // toString
  @override
  String toString() => 'UserModel(name: $name, email: $email, id: $id)';

  // So sánh đối tượng
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ id.hashCode;
}
