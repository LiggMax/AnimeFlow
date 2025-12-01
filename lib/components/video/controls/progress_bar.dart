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
      height: 20,
      child: Obx(() {
        final max = videoController.duration.value.inMilliseconds.toDouble();
        final value = videoController.position.value.inMilliseconds.toDouble();

        return SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
            activeTrackColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor: Colors.white.withOpacity(0.3),
            thumbColor: Theme.of(context).colorScheme.primary,
          ),
          child: Slider(
            value: value.clamp(0.0, max > 0 ? max : 1.0),
            min: 0.0,
            max: max > 0 ? max : 1.0,
            onChangeStart: (_) => videoController.startDrag(),
            onChanged: (v) {
              videoController.position.value = Duration(milliseconds: v.toInt());
            },
            onChangeEnd: (v) =>
                videoController.endDrag(Duration(milliseconds: v.toInt())),
          ),
        );
      }),
    );
  }
}