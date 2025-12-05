import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoStateController extends GetxController {
  final Player player;
  final RxBool _isPlaying = false.obs;//视频播放状态
  final RxBool _isControlsShow = true.obs; //视频空间显示状态

  bool get isPlaying => _isPlaying.value;
  bool get isControlsShow => _isControlsShow.value;

  //初始话player
  VideoStateController(this.player) {
    _isPlaying.value = player.state.playing;
  }

  ///暂停播放
  void pauseVideo() {
    player.pause();
  }

  ///显示或隐藏控制
  void toggleControls() {
    _isControlsShow.value = !_isControlsShow.value;
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
