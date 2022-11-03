import 'package:audioplayers/audioplayers.dart';

import '../constants/constants.dart';

class AudioProvider {
  // AudioPlayer player = AudioPlayer();
  final AudioPlayer player = AudioPlayer();

  playBgm() async {
    player.setReleaseMode(ReleaseMode.loop);
    player.setSourceAsset('assets/audio/');
    player.play(AssetSource(narutoBgm));
  }

  stopBgm() {
    player.stop();
  }
}
