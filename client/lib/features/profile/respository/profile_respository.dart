import 'dart:convert';
import 'dart:io';

import 'package:client/cor/constants/server_constant.dart';
import 'package:client/cor/failure/failure.dart';
import 'package:client/cor/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'profile_respository.g.dart';

@Riverpod(keepAlive: true)
ProfileRespository profileRespository(ProfileRespositoryRef ref) {
  return ProfileRespository(ref.watch(authLocalRepositoryProvider));
}

class ProfileRespository {
  final AuthLocalRepository _authLocalRepository;
  ProfileRespository(this._authLocalRepository);

  Future<Either<AppFailure, UserModel>> updateProfile({
    String? name,
    String? email,
    String? password,
    File? avatar
  }) async {
    try{
      final token = await _authLocalRepository.getToken();
      if(token == null){
        return Left(AppFailure('No authentication token found'));
      }
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${ServerConstant.serverUrl}/auth/update_profile'),
      );
      request.headers['x-auth-token'] = token;
      if(name != null && name.isNotEmpty){
        request.fields['name'] = name;
      }
      if(email != null && email.isNotEmpty){
        request.fields['email'] = email;
      }
      if(password != null && password.isNotEmpty){
        request.fields['password'] = password;
      }
      if(avatar!=null){
        request.files.add(
          await http.MultipartFile.fromPath('avatar',avatar.path),
        );
      }
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      final resBodyMap  = jsonDecode(response.body) as Map<String,dynamic>;

      if(response.statusCode != 200){
        return Left(AppFailure(resBodyMap['detail'] ?? 'Update Failed'));
      }
      return Right(UserModel.fromMap(resBodyMap).copyWith(token: token));
    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }
}
