import 'dart:io';
import 'package:client/cor/constants/server_constant.dart';
import 'package:client/cor/failure/failure.dart';
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
}