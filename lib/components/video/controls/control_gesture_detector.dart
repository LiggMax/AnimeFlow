import 'package:anime_flow/controllers/video/video_state_controller.dart';
import 'package:anime_flow/controllers/video/video_ui_state_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/platform_util.dart';

/// 视频控制手势检测器
class ControlGestureDetector extends StatefulWidget {
  final Widget child;

  const ControlGestureDetector({super.key, required this.child});

  @override
  State<ControlGestureDetector> createState() => _ControlGestureDetectorState();
}

class _ControlGestureDetectorState extends State<ControlGestureDetector> {
  double _dragStartX = 0; // 拖动开始时的X坐标
  double _dragStartY = 0; // 拖动开始时的Y坐标
  bool _isRightSide = false; // 是否在屏幕右半侧开始拖动
  String? _dragType; // 拖动类型：'horizontal'(水平) 或 'vertical'(垂直)

  @override
  Widget build(BuildContext context) {
    // 获取视频状态控制器
    final videoStateController = Get.find<VideoStateController>();
    final videoUiStateController = Get.find<VideoUiStateController>();

    // 获取屏幕尺寸，用于计算滑动距离和判断屏幕区域
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
      child: GestureDetector(
        // 双击事件：切换播放/暂停状态
        onDoubleTap: () {
          videoStateController.playOrPauseVideo();
        },

        // 单击事件：显示/隐藏播放器控件UI
        onTap: () {
          videoUiStateController.showOrHideControlsUi();
        },

        // 拖动开始事件：记录起始位置并判断屏幕区域
        onPanStart: (details) {
          // 记录拖动起始坐标
          _dragStartX = details.globalPosition.dx;
          _dragStartY = details.globalPosition.dy;

          // 判断是否在屏幕右半侧开始拖动
          _isRightSide = _dragStartX > screenWidth / 2;

          // 重置拖动类型，等待后续判断
          _dragType = null;
        },
        // 拖动更新事件：根据移动方向智能判断并执行相应操作
        onPanUpdate: (details) {
          // 获取当前拖动位置
          final currentX = details.globalPosition.dx;
          final currentY = details.globalPosition.dy;

          // 计算相对于起始位置的水平和垂直移动距离
          final deltaX = (currentX - _dragStartX).abs();
          final deltaY = (currentY - _dragStartY).abs();

          // 如果还没确定拖动类型，且移动距离超过阈值（10像素），则判断拖动方向
          if (_dragType == null && (deltaX > 10 || deltaY > 10)) {
            if (deltaX > deltaY) {
              // 水平移动距离大于垂直距离 → 水平拖动（调整播放进度）
              _dragType = 'horizontal';
              videoUiStateController.startHorizontalDrag(_dragStartX);
            } else {
              // 垂直移动距离大于水平距离
              if (_isRightSide) {
                // 且在右半屏 → 垂直拖动（调整音量）
                _dragType = 'vertical';
                videoStateController.startVerticalDrag();
              }
              // 左半屏的垂直拖动暂不处理，可扩展为调整亮度等功能
            }
          }

          // 根据已确定的拖动类型，持续更新相应的值
          if (_dragType == 'horizontal') {
            // 水平拖动：更新播放进度
            videoUiStateController.updateHorizontalDrag(currentX, screenWidth);
          } else if (_dragType == 'vertical' && _isRightSide) {
            // 垂直拖动（右半屏）：更新音量
            if (PlatformUtil.isMobile) {
              videoStateController.updateVerticalDrag(
                currentY - _dragStartY, // 拖动的垂直距离
                screenHeight, // 屏幕高度（用于计算音量变化百分比）
              );
            }
          }
        },
        // 拖动结束事件：完成拖动操作
        onPanEnd: (details) {
          if (_dragType == 'horizontal') {
            // 水平拖动结束：应用新的播放进度
            videoUiStateController.endHorizontalDrag();
          } else if (_dragType == 'vertical' && _isRightSide) {
            // 垂直拖动结束：应用新的音量并隐藏指示器
            videoStateController.endVerticalDrag();
          }

          // 重置拖动类型，准备下一次拖动
          _dragType = null;
        },

        // 拖动取消事件：用户中断拖动操作
        onPanCancel: () {
          if (_dragType == 'horizontal') {
            // 水平拖动取消：恢复到拖动前的播放位置
            videoUiStateController.cancelHorizontalDrag();
          } else if (_dragType == 'vertical' && _isRightSide) {
            // 垂直拖动取消：结束音量调整并隐藏指示器
            videoStateController.endVerticalDrag();
          }

          // 重置拖动类型
          _dragType = null;
        },
        child: widget.child,
      ),
    );
  }
}
