import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:get/get.dart';
import 'package:my_anime/controllers/TabTitleController.dart';

class StickyCategoryPage extends StatefulWidget {
  @override
  _StickyCategoryPageState createState() => _StickyCategoryPageState();
}

class _StickyCategoryPageState extends State<StickyCategoryPage>
    with TickerProviderStateMixin {
  final tabs = ["推荐", "热门", "最新", "科技", "生活"];
  late TabController _tabController;

  final titleController = Get.put(TabTitleController());
  double appBarOpacity = 0.0; // 标题栏透明度

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    titleController.setTitle("标题");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,

        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            /// ------------------ 顶部透明 AppBar ------------------
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: appBarOpacity == 1 ? Colors.white : Colors.transparent,
              elevation: appBarOpacity == 1 ? 0.5 : 0,
              title: appBarOpacity == 1
                  ? Text(
                "${titleController.title}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : null,
              flexibleSpace: LayoutBuilder(
                builder: (_, constraints) {
                  double offset = constraints.biggest.height;

                  double alpha = (200 - offset) / 60;
                  appBarOpacity = alpha.clamp(0, 1);

                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// ------------------ 分类 Tab 吸顶 ------------------
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabDelegate(
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.red,
                    tabs: tabs.map((e) => Tab(text: e)).toList(),
                  ),
                ),
              ),
            ),
          ];
        },

        /// ------------------ Tab 内容区域 ------------------
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((tab) {
            return _buildTabContent(tab);
          }).toList(),
        ),
      ),
    );
  }

  /// 内容区域（带背景图）
  Widget _buildTabContent(String tab) {
    return
      /// ----------- 内容列表 -----------
      ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 20,
        itemBuilder: (_, i) => Card(
          color: Colors.white.withValues(alpha: 0.92),
          child: ListTile(title: Text("$tab Item $i")),
        ),
      );
  }
}

/// 吸顶 Tab 代理类
class _StickyTabDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabDelegate({required this.child});

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(context, shrinkOffset, overlapsContent) => child;

  @override
  bool shouldRebuild(_StickyTabDelegate oldDelegate) => false;
}
