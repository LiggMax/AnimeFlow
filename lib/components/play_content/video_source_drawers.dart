import 'package:anime_flow/constants/play_layout_constant.dart';
import 'package:anime_flow/controllers/video/video_source_controller.dart';
import 'package:anime_flow/data/crawler/html_request.dart';
import 'package:anime_flow/models/void/episode_resources_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VideoSourceDrawers {
  /// 数据源侧边抽屉
  static void showSourceSideDrawer(BuildContext context, bool isVideoSource,
      List<EpisodeResourcesItem> episodesList,
      {String? title}) {
    print('接收到的数据： $episodesList');
    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: "SourceDrawer",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      // 动画
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: PlayLayoutConstant.playContentWidth,
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Material(
                    child: ListView.builder(
                      itemCount: episodesList.length,
                      itemBuilder: (context, index) {
                        final resourceItem = episodesList[index];
                        return Column(
                          children: resourceItem.episodes.map((episode) {
                            return Card.filled(
                                margin: EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  onTap: () async {
                                    final logger = Logger();
                                    final videoSourceController =
                                        Get.find<VideoSourceController>();

                                    try {
                                      // 显示加载提示
                                      Get.dialog(
                                        Center(
                                          child: Card(
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(height: 16),
                                                  Text('正在获取视频源...'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        barrierDismissible: false,
                                      );

                                      // 异步获取视频源
                                      final videoUrl = await WebRequest
                                          .getVideoSourceService(episode.like);

                                      logger.i('获取到视频源: $videoUrl');

                                      // 更新视频源到控制器
                                      videoSourceController
                                          .setVideoRul(videoUrl);

                                      // 关闭加载提示
                                      Get.back();

                                      // 关闭侧边抽屉
                                      Get.back();

                                      // 显示成功提示
                                      Get.snackbar(
                                        '成功',
                                        '视频源已切换',
                                        duration: Duration(seconds: 2),
                                      );
                                    } catch (e) {
                                      logger.e('获取视频源失败: $e');

                                      // 关闭加载提示（如果还在显示）
                                      if (Get.isDialogOpen == true) {
                                        Get.back();
                                      }

                                      // 显示错误提示
                                      Get.snackbar(
                                        '错误',
                                        '获取视频源失败: $e',
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red.shade100,
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 剧集标题
                                        Text(
                                          '第${episode.episodeSort}集',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        // 线路信息
                                        Row(
                                          children: [
                                            Icon(Icons.settings,
                                                size: 16, color: Colors.grey),
                                            SizedBox(width: 8),
                                            Spacer(),
                                            Text(
                                              episodesList[index].lineNames,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
