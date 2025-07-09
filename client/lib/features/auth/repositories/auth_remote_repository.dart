import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<String, Map<String, dynamic>>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('http://localhost:8000/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      if (res.statusCode != 201) {
        //handle the error
        return Left(res.body);
      }
      final user = jsonDecode(res.body) as Map<String, dynamic>;
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final res = await http.post(
        Uri.parse('http://localhost:8000/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print(res.body);
      print(res.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
