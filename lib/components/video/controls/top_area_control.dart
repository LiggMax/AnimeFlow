import 'package:anime_flow/controllers/episodes/episodes_controller.dart';
import 'package:anime_flow/controllers/play/PlayPageController.dart';
import 'package:anime_flow/controllers/video/video_ui_state_controller.dart';
import 'package:anime_flow/utils/platform_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

class TopAreaControl extends StatelessWidget {
  final String subjectName;
  final PlayPageController playPageController;
  final VideoUiStateController videoUiStateController;
  final EpisodesController episodesController;

  const TopAreaControl({
    super.key,
    required this.subjectName,
    required this.playPageController,
    required this.videoUiStateController,
    required this.episodesController,
  });

  @override
  Widget build(BuildContext context) {

    bool fullscreen = isFullscreen(context);

    return Obx(() => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: videoUiStateController.isShowControlsUi.value
              ? Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                          if (PlatformUtil.isDesktop || fullscreen)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subjectName,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                //后续添加剧集名称
                                Obx(() =>
                                    episodesController.episodeTitle.value != ''
                                        ? Text(
                                            episodesController
                                                .episodeTitle.value,
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 15),
                                          )
                                        : SizedBox.shrink())
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
                                      icon: playPageController
                                              .isContentExpanded.value
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
        ));
  }
}
