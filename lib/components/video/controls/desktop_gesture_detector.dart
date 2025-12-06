import 'package:anime_flow/controllers/video/video_state_controller.dart';
import 'package:anime_flow/controllers/video/video_ui_state_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 视频控制手势检测器
class ControlGestureDetector extends StatelessWidget {
  final Widget child;

  const ControlGestureDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final videoStateController = Get.find<VideoStateController>();
    final videoUiStateController = Get.find<VideoUiStateController>();

    return Listener(
        // 鼠标指针信号事件监听（用于鼠标滚轮）
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            // 处理鼠标滚轮事件：调整音量
            // 向上滚动增加音量，向下滚动减少音量
            // 除以20是为了控制调整幅度（每次约5%）
            var scrollDelta = event.scrollDelta.dy / 20;
            videoStateController.adjustVolumeByScroll(scrollDelta);
          }
        },
        child: MouseRegion(
          // 鼠标移入事件
          onEnter: (event) {
            videoUiStateController.showControlsUi();
          },

          // 鼠标移出事件
          onExit: (event) {
          },

          child: GestureDetector(
            // 双击事件
            onDoubleTap: () {
              //TODO 播放器全屏
            },

            // 单击事件
            onTap: () {
              videoStateController.playOrPauseVideo();
            },
            child: child,
          ),
        ));
  }
}
