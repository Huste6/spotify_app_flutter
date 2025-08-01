import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    state = const AsyncValue.loading();
    final authRepository = _authRemoteRepository;
    final res = await authRepository.signup(
        name: name, email: email, password: password);

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<void> LoginUser(
      {required String email, required String password}) async {
    state = const AsyncValue.loading();
    final authRepository = _authRemoteRepository;
    final res = await authRepository.login(email: email, password: password);

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _loginSuccess(r),
    };
    print(val);
  }

  Future<AsyncValue<UserModel>?> _loginSuccess(UserModel user) async {
    await _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
    try {
      state = const AsyncValue.loading();
      final token = await _authLocalRepository.getToken();
      if (token == null) {
        state = null;
        return null;
      }
      final res = await _authRemoteRepository.getCurrentUserData(token: token);
      final val = switch (res) {
        Left(value: final l) => {
            await _authLocalRepository.clearToken(),
            state = AsyncValue.error(l.message, StackTrace.current)
          },
        Right(value: final r) => _getDataSuccess(r),
      };
      return val is AsyncValue<UserModel> ? val.value : null;
    } catch (e) {
      print(e);
      state = null;
      return null;
    }
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    await _authLocalRepository.clearToken();
    _currentUserNotifier.removeUser();
    state = null;
  }
}
