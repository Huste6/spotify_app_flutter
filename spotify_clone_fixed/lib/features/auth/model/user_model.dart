import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final int id;
  final String token;
  const UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
  });

  // Chuyển đối tượng thành Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'token': token,
    };
  }

  // Tạo đối tượng từ Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? 0,
      token: map['token'] ?? '',
    );
  }

  // Chuyển đối tượng thành JSON string
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ JSON string
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // toString
  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, id: $id, token: $token)';
  }

  // So sánh đối tượng
  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ id.hashCode ^ token.hashCode;
  }

  UserModel copyWith({
    String? name,
    String? email,
    int? id,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
