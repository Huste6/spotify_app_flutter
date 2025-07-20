import 'dart:convert';
import 'dart:io';
import 'package:client/cor/constants/server_constant.dart';
import 'package:client/cor/failure/failure.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository { // Corrected typo
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songname,
    required String artist,
    required String hex_code,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstant.serverUrl}/song/upload'),
      );
      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath(
              'song',
              selectedAudio.path,

            ),
            await http.MultipartFile.fromPath(
              'thumbnail',
              selectedThumbnail.path,

            )
          ],
        )
        ..fields.addAll(
          {'artist': artist, 'song_name': songname, 'hex_code': hex_code},
        )
        ..headers.addAll(
          {'x-auth-token': token},
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response.body);
      } else {
        return Left(AppFailure('Server error: ${response.body}'));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.serverUrl}/song/list'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      // res.body trả về Json(String)
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail'] ?? 'Unknown error'));
      }

      resBodyMap = resBodyMap as List;
      final List<SongModel> songs = resBodyMap
          .map((songJson) => SongModel.fromMap(songJson))
          .toList();

      return Right(songs);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> favSong({
    required String token,
    required String songId
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/song/favorite'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
          "song_id": songId,
          },
        )
      );
      // res.body trả về Json(String)
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail'] ?? 'Unknown error'));
      }
      return Right(resBodyMap['message']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllFavSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.serverUrl}/song/list_favorite'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      // res.body trả về Json(String)
      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailure(resBodyMap['detail'] ?? 'Unknown error'));
      }

      resBodyMap = resBodyMap as List;
      final List<SongModel> songs = resBodyMap
          .map((songJson) => SongModel.fromMap(songJson['song']))
          .toList();

      return Right(songs);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}