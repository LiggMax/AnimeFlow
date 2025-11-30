import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late Subject subject;
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    subject = Get.arguments as Subject;

    player.open(
      Media(
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
      ),
    );
  }

  // 视频播放区域
  Widget playVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Video(controller: controller),
    );
  }

  //内容区域
  Widget content() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down)),
          Expanded(child: Center(child: Text(subject.nameCN ?? subject.name))),
        ],
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        top: false,
        child: Column(children: [playVideo(), content()]),
      ),
    );
  }
}
