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

  // 视频播放区域
  Widget playVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Video(controller: controller,),
    );
  }

  //内容区域
  Widget content() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down)),
          Expanded(child: Center(child: Text('标题标题标题标题标题'))),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    player.open(Media('https://media.w3.org/2010/05/sintel/trailer_hd.mp4'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [playVideo(), content()]);
  }
}
