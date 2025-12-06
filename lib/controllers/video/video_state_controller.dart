import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoStateController extends GetxController {
  final Player player;
  final RxBool _isPlaying = false.obs; //视频播放状态
  final RxDouble volume = 100.0.obs; //音量 0-100
  final RxBool showVolumeIndicator = false.obs; //是否显示音量指示器
  final RxBool isVerticalDragging = false.obs; //是否正在垂直拖动调整音量

  bool get isPlaying => _isPlaying.value;

  // 垂直拖动相关
  double _dragStartVolume = 100.0;

  //初始话player
  VideoStateController(this.player) {
    _isPlaying.value = player.state.playing;
    volume.value = player.state.volume;
    
    // 监听播放器音量变化
    player.stream.volume.listen((vol) {
      volume.value = vol;
    });
  }

  ///暂停|播放
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

  ///更新视频音量
  void updateVolume(double volume) {
    player.setVolume(volume);
  }

  ///滚轮调整音量
  void adjustVolumeByScroll(double delta) {
    // 限制音量在 0-100 之间
    double newVolume = (volume.value - delta).clamp(0.0, 100.0);
    updateVolume(newVolume);
    
    // 显示音量指示器
    showVolumeIndicator.value = true;
    
    // 3秒后隐藏音量指示器
    Future.delayed(const Duration(seconds: 2), () {
      showVolumeIndicator.value = false;
    });
  }

  // 开始垂直拖动调整音量
  void startVerticalDrag() {
    _dragStartVolume = volume.value;
    isVerticalDragging.value = true;
    showVolumeIndicator.value = true;
  }

  // 更新垂直拖动音量
  void updateVerticalDrag(double dragDistance, double screenHeight) {
    // 向上滑动增加音量，向下滑动减少音量
    // 滑动整个屏幕高度改变100%音量
    final volumeChange = -(dragDistance / screenHeight) * 100;
    double newVolume = (_dragStartVolume + volumeChange).clamp(0.0, 100.0);
    updateVolume(newVolume);
  }

  // 结束垂直拖动
  void endVerticalDrag() {
    isVerticalDragging.value = false;
    // 2秒后隐藏音量指示器
    Future.delayed(const Duration(seconds: 2), () {
      if (!isVerticalDragging.value) {
        showVolumeIndicator.value = false;
      }
    });
  }
}
