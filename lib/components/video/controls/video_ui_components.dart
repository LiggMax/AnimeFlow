import 'package:anime_flow/controllers/video/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 视频播放进度条组件
class VideoProgressBar extends StatelessWidget {
  final VideoController videoController;

  const VideoProgressBar({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Obx(() {
        final max = videoController.duration.value.inMilliseconds.toDouble();
        final value = videoController.position.value.inMilliseconds.toDouble();
        final buffer = videoController.buffer.value.inMilliseconds.toDouble();

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // 缓冲条
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                thumbShape: SliderComponentShape.noThumb, // 隐藏滑块
                overlayShape: SliderComponentShape.noOverlay,
                activeTrackColor: Colors.white.withValues(alpha: 0.4), // 缓冲颜色
                disabledActiveTrackColor: Colors.white.withValues(alpha: 0.4),
                disabledThumbColor: Colors.transparent,
                // 移除缓冲条默认的Padding，使其与带滑块的进度条对齐
                trackShape: _CustomTrackShape(),
              ),
              child: Slider(
                value: buffer.clamp(0.0, max > 0 ? max : 1.0),
                min: 0.0,
                max: max > 0 ? max : 1.0,
                onChanged: null, // 禁用交互
              ),
            ),
            // 播放进度条
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Colors.transparent, // 透明背景，露出缓冲条
                thumbColor: Theme.of(context).colorScheme.primary,
              ),
              child: Slider(
                value: value.clamp(0.0, max > 0 ? max : 1.0),
                min: 0.0,
                max: max > 0 ? max : 1.0,
                onChangeStart: (_) => videoController.startDrag(),
                onChanged: (v) {
                  videoController.position.value =
                      Duration(milliseconds: v.toInt());
                },
                onChangeEnd: (v) =>
                    videoController.endDrag(Duration(milliseconds: v.toInt())),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// 自定义TrackShape，用于解决缓冲条和进度条对齐问题
class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    // Flutter Slider 默认两端有 Padding 来容纳 Thumb
    // 这里手动模拟这个 Padding，确保无 Thumb 的 Slider 与有 Thumb 的 Slider 轨道长度一致
    final double trackLeft = offset.dx + 16; // 补偿 Thumb 半径
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 12; // 补偿两侧 Thumb 半径
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

/// 视频时间显示组件
class VideoTimeDisplay extends StatelessWidget {
  final VideoController videoController;

  const VideoTimeDisplay({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final position = videoController.position.value;
      final duration = videoController.duration.value;

      String formatDuration(Duration d) {
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
        if (d.inHours > 0) {
          return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
        }
        return "$twoDigitMinutes:$twoDigitSeconds";
      }

      return Text(
        "${formatDuration(position)} / ${formatDuration(duration)}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      );
    });
  }
}
