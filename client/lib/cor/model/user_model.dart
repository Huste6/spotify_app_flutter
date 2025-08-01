import 'dart:convert';
import 'package:client/features/home/model/fav_song_model.dart';

class UserModel {
  final String name;
  final String email;
  final int id;
  final String token;
  final List<FavSongModel> favorites;
  final String avatar;

  const UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
    required this.favorites,
    this.avatar = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'token': token,
      'favorites': favorites.map((x) => x.toMap()).toList(),
      'avatar': avatar
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'].toString(),
      email: map['email'].toString(),
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()) ?? 0,
      token: map['token'].toString(),
      favorites: (map['favorites'] != null && map['favorites'] is List)
          ? List<FavSongModel>.from(
        (map['favorites'] as List).map(
              (favMap) => FavSongModel.fromMap(
            favMap as Map<String, dynamic>,
          ),
        ),
      )
          : [],
      avatar: map['avatar'].toString()
    );
  }


  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, id: $id, token: $token, favorites: $favorites, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.id == id &&
        other.token == token &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ id.hashCode ^ token.hashCode ^ avatar.hashCode;
  }

  UserModel copyWith({
    String? name,
    String? email,
    int? id,
    String? token,
    List<FavSongModel>? favorites,
    String? avatar,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
      avatar: avatar ?? this.avatar
    );
  }
}
