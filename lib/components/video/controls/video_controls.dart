import 'package:anime_flow/models/hot_item.dart';
import 'package:anime_flow/controllers/video/video_controller.dart'
    as controller;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:anime_flow/components/video/controls/video_ui_components.dart';

///播放器控件
class VideoControlsUi extends StatefulWidget {
  final Subject subject;
  final Player player;

  const VideoControlsUi(this.player, {super.key, required this.subject});

  @override
  State<VideoControlsUi> createState() => _VideoControlsUiState();
}

class _VideoControlsUiState extends State<VideoControlsUi> {
  late controller.VideoController videoController;

  @override
  void initState() {
    videoController = Get.put(controller.VideoController(widget.player));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<VideoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //使用media_kit_video提供的全屏判断
    bool fullscreen = isFullscreen(context);
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
                children: [
                  Row(children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white.withValues(alpha: 0.8),
                        )),
                    SizedBox(width: 5),
                    if (fullscreen)
                      Column(
                        children: [
                          Text(
                            widget.subject.nameCN ?? widget.subject.name,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                          //后续添加剧集名称
                        ],
                      )
                  ]),
                  //右侧
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0),
                          icon: SvgPicture.asset(
                            "lib/assets/icons/right_panel_close.svg",
                            width: 30,
                            height: 30,
                            colorFilter: ColorFilter.mode(
                                Colors.white70, BlendMode.srcIn),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )),

      ///中间

      Positioned(
          top: 40,
          left: 0,
          right: 0,
          bottom: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 播放状态图标
              PlayStatusIcon(videoController),
            ],
          )),

      ///底部
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 时间显示组件
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: VideoTimeDisplay(videoController: videoController),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 播放按钮
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: RotationTransition(
                                turns: Tween<double>(begin: 0.5, end: 1.0)
                                    .animate(animation),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Obx(() => IconButton(
                            padding: EdgeInsets.all(0),
                            key: ValueKey<bool>(videoController.isPlaying),
                            onPressed: videoController.togglePlay,
                            icon: Icon(
                              videoController.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 33,
                              color: Colors.white.withValues(alpha: 0.8),
                            ))),
                      ),

                      // 进度条
                      Expanded(
                        child:
                            VideoProgressBar(videoController: videoController),
                      ),

                      // 全屏按钮
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: IconButton(
                          //使用media_kit_video提供的全屏方法
                          onPressed: () => toggleFullscreen(context),
                          padding: EdgeInsets.all(0),
                          icon: fullscreen
                              ? Icon(
                                  size: 33,
                                  Icons.fullscreen_exit,
                                  color: Colors.white.withValues(alpha: 0.8),
                                )
                              : Icon(
                                  size: 33,
                                  Icons.fullscreen,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ))
    ]);
  }
}
