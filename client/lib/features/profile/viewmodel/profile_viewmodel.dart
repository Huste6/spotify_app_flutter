import 'dart:io';
import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/model/user_model.dart';
import 'package:client/features/profile/respository/profile_respository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_viewmodel.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  late ProfileRespository _profileRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _profileRepository = ref.watch(profileRespositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    File? avatar,
  }) async {
    state = const AsyncValue.loading();

    try {
      final res = await _profileRepository.updateProfile(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
      );

      final val = switch (res) {
        Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => _updateSuccess(r),
      };

      print(val);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  AsyncValue<UserModel> _updateSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}