import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

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
        'https://p3-dcd-sign.byteimg.com/tos-cn-i-f042mdwyw7/7905eccbf0d849c9abd9aef1421e3dca~tplv-jxcbcipi3j-image.image?lk3s=13ddc783&x-expires=1764545530&x-signature=FvI9lbJMwGK4BI%2FNtI9ktvUvM%2Bw%3D',
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Video(controller: controller),
    );
  }
}
