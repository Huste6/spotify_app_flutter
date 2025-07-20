import 'package:client/cor/model/user_model.dart';
import 'package:client/cor/providers/current_user_notifier.dart';
import 'package:client/cor/theme/theme.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  final container = ProviderContainer();

  try {
    await container.read(authViewModelProvider.notifier).initSharedPreferences();
    final userdata = await container.read(authViewModelProvider.notifier).getData();
    runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
  } catch (e) {
    print('Error during initialization: $e');
    runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    final authState = ref.watch(authViewModelProvider);

    return MaterialApp(
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: _buildHome(currentUser,authState),
    );
  }

  Widget _buildHome(currentUser, AsyncValue<UserModel>? authState){
    if(authState?.isLoading == true){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(currentUser!=null){
      return const HomePage();
    }
    return const LoginPage();
  }
}
