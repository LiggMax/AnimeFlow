import 'package:anime_flow/models/episodes_item.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroduceView extends StatelessWidget {
  final Subject subject;
  final Future<EpisodesItem> episodes;

  const IntroduceView(this.subject, this.episodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.nameCN ?? subject.name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("选集"),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            _episodesDrawer(context),
                            ignoreSafeArea: true,
                            isScrollControlled: true, // 允许控制高度和滚动
                            backgroundColor: Colors.transparent,
                          );
                        },
                        icon: Icon(Icons.more_horiz_rounded),
                      )
                    ],
                  ),
                  //横向滚动卡片
                  _scrollTheCardHorizontally()
                ],
              )
            ],
          ),
        ));
  }

  //剧集抽屉
  Widget _episodesDrawer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // 增加高度
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Column(
        children: [
          // 顶部指示条，提示可以拖拽
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          Expanded(
            child: FutureBuilder<EpisodesItem>(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('加载失败'));
                } else if (snapshot.hasData) {
                  final episodeList = snapshot.data!.data;
                  return LayoutBuilder(builder: (context, constraints) {
                    // 使用 Wrap 实现自适应高度的网格布局
                    final double spacing = 8.0;
                    // 计算每个卡片的宽度（减去中间间距）
                    final double itemWidth =
                        (constraints.maxWidth - spacing) / 2;

                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(), // 确保总是可以滚动
                      child: Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: episodeList.map((episode) {
                          return SizedBox(
                            width: itemWidth,
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '第${episode.sort}话',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      episode.nameCN.isNotEmpty
                                          ? episode.nameCN
                                          : episode.name,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  });
                } else {
                  return const Center(child: Text('暂无章节数据'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //横向滚动卡片
  FutureBuilder<EpisodesItem> _scrollTheCardHorizontally() {
    return FutureBuilder<EpisodesItem>(
      future: episodes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final episodeList = snapshot.data!.data;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                episodeList.length,
                (index) {
                  final episode = episodeList[index];
                  return Card(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('第${episode.sort}话'),
                          SizedBox(height: 5),
                          Text(
                            episode.nameCN.isNotEmpty
                                ? episode.nameCN
                                : episode.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const Text('暂无章节数据');
        }
      },
    );
  }
}
