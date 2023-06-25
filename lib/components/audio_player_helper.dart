import 'package:just_audio/just_audio.dart';

class AudioHelper {
  static AudioPlayer audioPlayer = AudioPlayer();

  static void loadAsset() async {
    try {
      await audioPlayer.setAsset("assets/beep.mp3");
      await audioPlayer.load();
    } catch (_) {}
  }

  static void playAudio() async {
    await audioPlayer.play();
    audioPlayer.load();
  }
}
