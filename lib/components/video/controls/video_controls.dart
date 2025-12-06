import 'package:anime_flow/components/video/controls/desktop_gesture_detector.dart';
import 'package:anime_flow/controllers/play/PlayPageController.dart';
import 'package:anime_flow/controllers/video/video_state_controller.dart';
import 'package:anime_flow/models/enums/video_controls_icon_type.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:anime_flow/controllers/video/video_ui_state_controller.dart';
import 'package:anime_flow/utils/timeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:anime_flow/components/video/controls/video_ui_components.dart';
import 'package:anime_flow/utils/platform_util.dart';

import 'mobile_gesture_detector.dart';

///播放器控件
class VideoControlsUi extends StatefulWidget {
  final Subject subject;
  final Player player;

  const VideoControlsUi(this.player, {super.key, required this.subject});

  @override
  State<VideoControlsUi> createState() => _VideoControlsUiState();
}

class _VideoControlsUiState extends State<VideoControlsUi> {
  late VideoUiStateController videoUiStateController;
  late PlayPageController playPageController;
  late VideoStateController videoStateController;

  @override
  void initState() {
    videoUiStateController = Get.find<VideoUiStateController>();
    playPageController = Get.find<PlayPageController>();
    videoStateController = Get.find<VideoStateController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ///顶部
      Obx(() => buildTopArea()),

      ///中间占满剩余区域
      Expanded(
          child: PlatformUtil.isMobile
              //移动端手势
              ? MobileGestureDetector(child: buildMiddleArea(widget.player))
              //桌面端手势
              : DesktopGestureDetector(child: buildMiddleArea(widget.player))),

      ///底部
      Obx(() => buildBottomArea(widget.player))
    ]);
  }

  //顶部区域组件
  Widget buildTopArea() {
    //使用media_kit_video提供的全屏判断
    bool fullscreen = isFullscreen(context);
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: videoUiStateController.isShowControlsUi.value
          ? Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black45, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Row(
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
                        if (PlatformUtil.isDesktop)
                          Obx(() => playPageController.isWideScreen.value
                              ? IconButton(
                                  onPressed: () => playPageController
                                      .toggleContentExpanded(),
                                  padding: EdgeInsets.all(0),
                                  icon:
                                      playPageController.isContentExpanded.value
                                          ? SvgPicture.asset(
                                              "lib/assets/icons/right_panel_close.svg",
                                              width: 30,
                                              height: 30,
                                              colorFilter: ColorFilter.mode(
                                                Colors.white70,
                                                BlendMode.srcIn,
                                              ),
                                            )
                                          : SvgPicture.asset(
                                              "lib/assets/icons/left_panel_close.svg",
                                              width: 30,
                                              height: 30,
                                              colorFilter: ColorFilter.mode(
                                                Colors.white70,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                )
                              : SizedBox.shrink())
                      ],
                    )
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }

  //中间区域组件
  Widget buildMiddleArea(Player player) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //指示器Icon
          Obx(() => videoUiStateController.isShowIndicatorUi.value
              ? switch (videoUiStateController.indicatorType.value) {
                  //无指示器
                  VideoControlsIndicatorType.noIndicator => SizedBox.shrink(),

                  //缓冲指示器
                  VideoControlsIndicatorType.bufferingIndicator => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '缓冲中...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  //音量指示器
                  VideoControlsIndicatorType.volumeIndicator => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            videoStateController.volume.value == 0
                                ? Icons.volume_off
                                : videoStateController.volume.value < 50
                                    ? Icons.volume_down
                                    : Icons.volume_up,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: LinearProgressIndicator(
                              value: videoStateController.volume.value / 100,
                              backgroundColor: Colors.white30,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.primary),
                            ),
                          )
                        ],
                      ),
                    ),

                  //解析指示器
                  VideoControlsIndicatorType.parsingIndicator => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '缓冲中...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  //播放状态指示器
                  VideoControlsIndicatorType.playStatusIndicator => Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        videoStateController.playing.value
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 33,
                        color: Colors.white54,
                      ),
                    ),

                  //横向拖动指示器
                  VideoControlsIndicatorType.horizontalDraggingIndicator =>
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${TimeUtil.formatDuration(videoUiStateController.dragPosition.value)} / ${TimeUtil.formatDuration(videoUiStateController.duration.value)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                }
              : SizedBox.shrink()),
        ],
      ),
    );
  }

  //底部区域组件
  Widget buildBottomArea(Player player) {
    //使用media_kit_video提供的全屏判断
    bool fullscreen = isFullscreen(context);
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: videoUiStateController.isShowControlsUi.value
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black38,
                  Colors.transparent,
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 时间显示组件
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: VideoTimeDisplay(
                          videoController: videoUiStateController),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 播放按钮
                        Obx(() => IconButton(
                            padding: EdgeInsets.all(0),
                            key: ValueKey<bool>(
                                videoStateController.playing.value),
                            onPressed: () => {
                                  videoStateController.playOrPauseVideo(),
                                  videoUiStateController.updateIndicatorType(
                                      VideoControlsIndicatorType
                                          .playStatusIndicator),
                                  videoUiStateController.showIndicator()
                                },
                            icon: Icon(
                              videoStateController.playing.value
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 33,
                              color: Colors.white.withValues(alpha: 0.8),
                            ))),

                        // 进度条
                        Expanded(
                          child: VideoProgressBar(
                              videoUiStateController: videoUiStateController),
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
            )
          : SizedBox.shrink(),
    );
  }
}
