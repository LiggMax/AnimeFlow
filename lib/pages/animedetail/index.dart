import 'dart:ui';

import 'package:anime_flow/controllers/title_controller.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'head_detail.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage>
    with SingleTickerProviderStateMixin {
  late Subject animeData;
  late TabController _tabController;
  double _appBarOpacity = 0.0;

  final titleList = ["推荐", "热门", "最新"];

  @override
  void initState() {
    super.initState();
    animeData = Get.arguments as Subject;

    Get.put(TitleController());

    _tabController = TabController(length: titleList.length, vsync: this);

    // 初始标题
    Get.find<TitleController>().updateTitle(animeData.nameCN??animeData.name);
  }

  @override
  Widget build(BuildContext context) {
    final titleController = Get.find<TitleController>();

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (scroll.metrics.axis == Axis.vertical) {
            double offset = scroll.metrics.pixels;

            // 背景图高度
            double trigger = 200;

            setState(() {
              _appBarOpacity = (offset / trigger).clamp(0, 1);
            });
          }
          return false;
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            var primaryColor = Theme.of(context).primaryColor;
            return [
              /// 顶部透明 → 不透明 AppBar
              SliverAppBar(
                pinned: true,
                expandedHeight: 260,
                backgroundColor: Colors.white.withValues(alpha: _appBarOpacity),
                elevation: 0,
                title: Obx(
                  () => Opacity(
                    opacity: _appBarOpacity,
                    child: Text(
                      titleController.currentTitle.value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: [
                    /// 背景
                    Opacity(
                      opacity: (1 - _appBarOpacity).clamp(0.0, 1.0),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.network(
                          animeData.images.large,
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    /// 半透明遮罩层
                    Opacity(
                      opacity: (1 - _appBarOpacity).clamp(0.0, 1.0),
                      child: Container(color: Colors.black.withValues(alpha: 0.3)),
                    ),

                    /// 内容层
                    Positioned(
                      bottom: 0,
                      left: 10,
                      right: 10,
                      child: Opacity(
                        opacity: (1 - _appBarOpacity).clamp(0.0, 1.0),
                        child: HeadDetailView(data: animeData),
                      ),
                    ),
                  ],
                ),
              ),

              /// 粘性TabBar
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: primaryColor,
                    indicatorColor: primaryColor,
                    tabs: titleList.map((e) => Tab(text: e)).toList(),
                  ),
                ),
              ),
            ];
          },

          /// TabBarView 内容
          body: TabBarView(
            controller: _tabController,
            children: titleList.map((title) {
              return Center(
                child: Text("页面内容：$title", style: TextStyle(fontSize: 24)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// TabBar 粘住吸顶
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) => false;
}
