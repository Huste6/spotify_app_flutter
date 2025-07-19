import 'dart:io';
import 'dart:ui';
import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/utils.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/respository/home_local_respository.dart';
import 'package:client/features/home/respository/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async{
  final token = ref.watch(currentUserNotifierProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);
  return switch(res){
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
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  List<SongModel> getRecentlyPlayedSong(){
    return _homeLocalRespository.loadSongs();
  }
}
