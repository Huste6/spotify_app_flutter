import 'dart:io';

import 'package:client/cor/constants/server_constant.dart';
import 'package:http/http.dart' as http;

class HomeRespository {
  Future<void> uploadSong(File selectedImage, File selectedAudio) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ServerConstant.serverUrl}/song/upload'),
    );
    request
      ..files.addAll(
        [
          await http.MultipartFile.fromPath(
              'song', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail',
              selectedImage.path)
        ],
      )
      ..fields.addAll(
        {'artist': 'Quan', 'song_name': 'thien menh', 'hex_code': 'FFFFFF'},
      )
      ..headers.addAll(
        {
          'x-auth-token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTh9.zaEGDL4jdN-GnPFuZAQzGLxVcRUOqxDEdQQaQLzJ_1A'
        },
      );
    final res = await request.send();
    print(res);
  }
}
