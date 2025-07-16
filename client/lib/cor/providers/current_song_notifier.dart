import 'package:client/features/home/model/song_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';
part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier{
  AudioPlayer? audioPlayer;
  bool isPlaying = false;

  @override
  SongModel? build(){
    return null;
  }

  void updateSong(SongModel song) async{
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(song.song_url));
    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.playerStateStream.listen((state){
      if(state.processingState == ProcessingState.completed){
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;
        this.state = this.state?.copyWith(hexCode: this.state?.hexCode);
      }
    });

    audioPlayer!.play();
    isPlaying = true;
    state = song;
  }

  void playPause(){
    if(isPlaying){
      audioPlayer?.pause();
    }else{
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    // Câu này thoạt nhìn thì sẽ tưởng vô nghĩa nhưng nó gọi cpwith để tạo 1 object y chang cái cũ, chỉ để ép riverpod nhận ra là "state đã thay đổi" dù giá trị không đổi
    // Tác dụng ép các widget rebuild từ đó có thể đổi được icon pause/play
    state = state?.copyWith(hexCode: state?.hexCode);
  }

  void seek(double val) async {
    if(audioPlayer == null || audioPlayer!.duration == null) return;
    final duration = audioPlayer!.duration!;
    final position = duration*val;
    try{
      await audioPlayer!.seek(position);
    }catch(e){
      debugPrint(e as String?);
    }
  }
}