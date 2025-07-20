import 'dart:io';
import 'dart:ui';
import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/utils.dart';
import 'package:client/features/home/model/fav_song_model.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/respository/home_local_respository.dart';
import 'package:client/features/home/respository/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}

@riverpod
Future<List<SongModel>> getFavSongs(GetFavSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res =
      await ref.watch(homeRepositoryProvider).getAllFavSongs(token: token);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRespository;
  late HomeLocalRespository _homeLocalRespository;
  @override
  AsyncValue? build() {
    _homeRespository = ref.watch(homeRepositoryProvider);
    _homeLocalRespository = ref.watch(homeLocalRespositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songname,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRespository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songname: songname,
      artist: artist,
      hex_code: rgbToHex(selectedColor),
      token: ref.read(currentUserNotifierProvider)!.token,
    );
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  List<SongModel> getRecentlyPlayedSong() {
    return _homeLocalRespository.loadSongs();
  }

  Future<void> favSong({required String songId}) async {
    state = const AsyncValue.loading();
    final res = await _homeRespository.favSong(
        token: ref.read(currentUserNotifierProvider)!.token, songId: songId);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _favSongSuccess(r, songId),
    };
    print(val);
  }

  AsyncValue _favSongSuccess(bool isFavorited, String songId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    if (isFavorited) {
      userNotifier.addUser(
          ref.read(currentUserNotifierProvider)!.copyWith(
            favorites: [
              ...ref.read(currentUserNotifierProvider)!.favorites,
              FavSongModel(id: '', song_id: songId, user_id: '')
            ],
          )
      );
    } else {
      userNotifier.addUser(
          ref.read(currentUserNotifierProvider)!.copyWith(
            favorites: ref
                .read(currentUserNotifierProvider)!
                .favorites
                .where((fav) => fav.song_id != songId)
                .toList(),
          )
      );
    }
    ref.invalidate(getFavSongsProvider);
    return state = AsyncValue.data(isFavorited);
  }
}
