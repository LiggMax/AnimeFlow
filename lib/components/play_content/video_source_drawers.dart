import 'package:anime_flow/constants/play_layout_constant.dart';
import 'package:anime_flow/models/void/episode_resources_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                  onTap: () {
                                    // Get.back();
                                    print(episode.like);
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
                                              '线路${index + 1}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[400]),
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
    );
  }
}
