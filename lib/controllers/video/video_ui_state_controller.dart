import 'dart:async';

import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

class VideoUiStateController extends GetxController {
  final Player player;
  final RxBool _isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> buffer = Duration.zero.obs;
  final RxBool isBuffering = false.obs; // 是否正在缓冲
  final RxBool isDragging = false.obs; // 是否正在拖拽进度条
  final RxBool showPlayStatusIcon = false.obs; // 是否显示播放状态图标
  final RxBool isParsing = false.obs; //是否正在解析视频资源

  // 控制图标显示的计时器
  Timer? _iconTimer;

  VideoUiStateController(this.player) {
    // 初始化状态，防止 player 已经加载完成导致 stream 不触发
    duration.value = player.state.duration;
    position.value = player.state.position;
    _isPlaying.value = player.state.playing;
    buffer.value = player.state.buffer;

    // 监听播放器播放状态变化
    player.stream.playing.listen((playing) {
      _isPlaying.value = playing;
    });

    // 监听进度
    player.stream.position.listen((pos) {
      if (!isDragging.value) {
        position.value = pos;
      }
    });

    // 监听总时长
    player.stream.duration.listen((dur) {
      duration.value = dur;
    });

    // 监听缓冲进度
    player.stream.buffer.listen((buf) {
      buffer.value = buf;
    });

    // 监听缓冲状态 - 只有在有视频源时才显示缓冲动画
    player.stream.buffering.listen((buffering) {
      // 只有当播放器有内容（duration > 0）时才显示缓冲状态
      if (duration.value > Duration.zero) {
        isBuffering.value = buffering;
      }
    });
  }

  // 播放状态
  bool get isPlaying => _isPlaying.value;

  void togglePlay() {
    if (_isPlaying.value) {
      player.pause();
    } else {
      player.play();
    }
    _showIcon();
  }

  // 显示播放状态图标
  void _showIcon() {
    showPlayStatusIcon.value = true;
    _iconTimer?.cancel();
    _iconTimer = Timer(const Duration(seconds: 3), () {
      showPlayStatusIcon.value = false;
    });
  }

  // 跳转到指定位置
  void seekTo(Duration pos) {
    player.seek(pos);
  }

  // 开始拖拽
  void startDrag() {
    isDragging.value = true;
  }

  // 结束拖拽
  void endDrag(Duration pos) {
    isDragging.value = false;
    seekTo(pos);
  }

  //更新资源解析状态
  void updateParsingStatus(bool isParsing) {
    this.isParsing.value = isParsing;
  }

  @override
  void onClose() {
    _iconTimer?.cancel();
    super.onClose();
  }
}
