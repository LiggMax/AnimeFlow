import 'package:anime_flow/components/video/controls/video_controls.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoView extends StatefulWidget {
  final Subject subject;

  const VideoView({super.key, required this.subject});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(
      Media(
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Video(
          controller: controller,
          controls: (state) => VideoControlsUi(
            player,
            subject: widget.subject,
          ),
        ),
      ],
    );
  }
}
