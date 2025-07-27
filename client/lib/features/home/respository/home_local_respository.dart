import 'package:client/features/home/model/song_model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_local_respository.g.dart';

@riverpod
HomeLocalRespository homeLocalRespository(HomeLocalRespositoryRef ref) {
  return HomeLocalRespository();
}

class HomeLocalRespository {
  final Box box = Hive.box();

  void uploadLocalSong(SongModel song) {
    box.put(song.id, song.toJson());
  }

  List<SongModel> loadSongs() {
    List<SongModel> songs = [];
    for (final key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
    }
    return songs;
  }

  void deleteSong(String songId) {
    box.delete(songId);
  }

  void deleteAllSongs() {
    box.clear();
  }

  bool isSongExists(String songId) {
    return box.containsKey(songId);
  }
}
