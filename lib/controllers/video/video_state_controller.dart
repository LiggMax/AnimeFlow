import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoStateController extends GetxController {
  final Player player;
  final RxBool _isPlaying = false.obs;//视频播放状态

  bool get isPlaying => _isPlaying.value;

  //初始话player
  VideoStateController(this.player) {
    _isPlaying.value = player.state.playing;
  }

  ///暂停或播放
  void playOrPauseVideo() {
    player.playOrPause();
  }

  /// 清理播放资源
  void disposeVideo() {
    player.open(
      Media(
        '',
      ),
    );
  }
}
