import 'package:anime_flow/controllers/title_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickyCategoryPage extends StatefulWidget {
  @override
  State<StickyCategoryPage> createState() => _StickyCategoryPageState();
}

class _StickyCategoryPageState extends State<StickyCategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _appBarOpacity = 0.0;

  final titleList = ["推荐", "热门", "最新", "分类 A", "分类 B", "分类 C"];

  @override
  void initState() {
    super.initState();

    Get.put(TitleController());

    _tabController = TabController(length: titleList.length, vsync: this);

    // tab 切换时更新标题
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        Get.find<TitleController>().updateTitle(titleList[_tabController.index]);
      }
    });

    // 初始标题
    Get.find<TitleController>().updateTitle(titleList[0]);
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
            return [
              /// 顶部透明 → 不透明 AppBar
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                backgroundColor: Colors.white.withOpacity(_appBarOpacity),
                elevation: 0,
                title: Obx(() => Opacity(
                  opacity: _appBarOpacity,
                  child: Text(
                    titleController.currentTitle.value,
                    style: TextStyle(color: Colors.black),
                  ),
                )),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Image.network(
                    "https://picsum.photos/800/600",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 吸顶 TabBar
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.red,
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
                child: Text("页面内容：$title",
                    style: TextStyle(fontSize: 24)),
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
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) => false;
}
