import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

///播放器控件
class VideoControlsUi extends StatefulWidget {
  const VideoControlsUi({super.key});

  @override
  State<VideoControlsUi> createState() => _VideoControlsUiState();
}

class _VideoControlsUiState extends State<VideoControlsUi> {
  bool isFullScreen = false;

  void _toggleFullscreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });

    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      print("进入全屏");
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      print("退出全屏");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      ///顶部
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withValues(alpha: 0.5),
              Colors.transparent
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Row(
                ///两侧对齐
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white.withValues(alpha: 0.8),
                      ))
                ],
              ),
            ),
          )),

      ///底部
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //交叉轴底部对齐
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.volume_up,
                        color: Colors.white.withValues(alpha: 0.8),
                      )),
                  IconButton(
                      onPressed: () {
                        _toggleFullscreen();
                      },
                      icon: Icon(
                        size: 33,
                        Icons.fullscreen,
                        color: Colors.white.withValues(alpha: 0.8),
                      ))
                ],
              ),
            ),
          ))
    ]);
  }
}
