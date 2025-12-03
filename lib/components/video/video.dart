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
        'https://m3u8.girigirilove.com/addons/aplyer/atom.php?key=0&amp;url=https://ai.girigirilove.net/zijian/oldanime/2025/10/cht/SPYxFAMILYS3CHT/38/playlist.m3u8',
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
