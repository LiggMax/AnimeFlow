import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoStateController extends GetxController {
  final Player player;

  //初始话player
  VideoStateController(this.player);

  ///暂停播放
  void pauseVideo() {
    player.pause();
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
