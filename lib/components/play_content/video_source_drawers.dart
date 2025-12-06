import 'package:anime_flow/constants/play_layout_constant.dart';
import 'package:anime_flow/controllers/video/video_source_controller.dart';
import 'package:anime_flow/controllers/video/video_state_controller.dart';
import 'package:anime_flow/data/crawler/html_request.dart';
import 'package:anime_flow/models/item/video/episode_resources_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VideoSourceDrawers extends StatefulWidget {
  final String title;
  final List<EpisodeResourcesItem> episodesList;

  const VideoSourceDrawers(this.title, this.episodesList, {super.key});

  @override
  State<VideoSourceDrawers> createState() => _VideoSourceDrawersState();
}

class _VideoSourceDrawersState extends State<VideoSourceDrawers> {
  late VideoSourceController videoSourceController;
  late VideoStateController videoStateController;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    videoStateController = Get.find<VideoStateController>();
    videoSourceController = Get.find<VideoSourceController>();
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.title,
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
                  itemCount: widget.episodesList.length,
                  itemBuilder: (context, index) {
                    final resourceItem = widget.episodesList[index];
                    return Column(
                      children: resourceItem.episodes.map((episode) {
                        return Card.filled(
                            margin: EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () async {
                                try {
                                  Get.back();

                                  // 清理播放资源
                                  videoStateController.disposeVideo();
                                  // 异步获取视频源
                                  final videoUrl =
                                      await WebRequest.getVideoSourceService(
                                          episode.like);

                                  // 更新视频源到控制器
                                  videoSourceController.setVideoUrl(videoUrl);

                                  // 显示成功提示
                                  Get.snackbar(
                                    '视频资源解析成功',
                                    '',
                                    duration: Duration(seconds: 2),
                                    maxWidth: 300,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          widget.episodesList[index].lineNames,
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
  }
}
