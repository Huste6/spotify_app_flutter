import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@riverpod
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setToken(String? token) async {
    await init();
    if (token != null) {
      await _sharedPreferences?.setString('x-auth-token', token);
    }
  }

  Future<String?> getToken() async {
    await init();
    return _sharedPreferences?.getString('x-auth-token');
  }
}
