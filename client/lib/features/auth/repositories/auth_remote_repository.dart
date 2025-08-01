import 'dart:convert';
import 'package:client/cor/constants/server_constant.dart';
import 'package:client/cor/failure/failure.dart';
import 'package:client/cor/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        //handle the error
        //{'detail': 'error message'}
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        //handle the error
        //{'detail': 'error message'}
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap['user'])
          .copyWith(token: resBodyMap['token']));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(
      {required String token}) async {
    try {
      final res = await http
          .get(Uri.parse('${ServerConstant.serverUrl}/auth/'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      });
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap).copyWith(token: token));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
