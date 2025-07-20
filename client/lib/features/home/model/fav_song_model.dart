//ignore_for_file: non_constant_identifier_names

class FavSongModel {
  final String id;
  final String song_id;
  final String user_id;

  const FavSongModel({
    required this.id,
    required this.song_id,
    required this.user_id,
  });

  factory FavSongModel.fromJson(Map<String, dynamic> json) {
    return FavSongModel(
      id: json['id'] as String,
      song_id: json['song_id'] as String,
      user_id: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'song_id': song_id,
      'user_id': user_id,
    };
  }

  FavSongModel copyWith({
    String? id,
    String? songId,
    String? userId,
  }) {
    return FavSongModel(
      id: id ?? this.id,
      song_id: songId ?? song_id,
      user_id: userId ?? user_id,
    );
  }

  factory FavSongModel.fromMap(Map<String, dynamic> map) {
    return FavSongModel(
      id: map['id'].toString(),
      song_id: map['song_id'].toString(),
      user_id: map['user_id'].toString(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'song_id': song_id,
      'user_id': user_id,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavSongModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          song_id == other.song_id &&
          user_id == other.user_id;

  @override
  int get hashCode => id.hashCode ^ song_id.hashCode ^ user_id.hashCode;

  @override
  String toString() {
    return 'FavSongModel(id: $id, song_id: $song_id, user_id: $user_id)';
  }
}
