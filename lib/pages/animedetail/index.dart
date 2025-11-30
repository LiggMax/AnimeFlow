import 'package:flutter/material.dart';
import 'dart:math' as math;

// 1. TabBar 吸顶 Delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color baseColor; // 接收基础颜色

  _SliverAppBarDelegate(this.tabBar, {required this.baseColor});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TabBar 在吸顶时 (minExtent) 统一使用标题栏完全不透明时的背景色
    return Container(
      color: baseColor, // 使用 baseColor 作为吸顶后的背景色
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    // 只有当 TabBar 或 baseColor 发生变化时才需要重建
    return oldDelegate.tabBar != tabBar || oldDelegate.baseColor != baseColor;
  }
}

// 2. 主页面 (添加了内容延伸和颜色统一逻辑)
class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Tab A', 'Tab B', 'Tab C'];
  double _appBarOpacity = 0.0;
  final double _contentHeight = 200.0; // 内容区域的高度

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 滚动通知处理
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      final double currentOffset = notification.metrics.pixels;

      // 计算标题栏应该不透明的滚动距离
      // 当滚动距离达到内容区域高度(_contentHeight)时，完全不透明。
      final double newOpacity = math.min(1.0, currentOffset / _contentHeight);

      if (newOpacity != _appBarOpacity) {
        setState(() {
          _appBarOpacity = newOpacity;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // 基础的AppBar颜色 (例如蓝色)
    const Color baseColor = Colors.blue;
    // 动态计算的背景色
    final Color dynamicBackgroundColor = baseColor.withOpacity(_appBarOpacity);

    // 动态计算标题文本颜色
    final Color titleColor = _appBarOpacity < 0.5 ? Colors.white : Colors.white; // 这里选择白色，因为 baseColor 是蓝色

    return Scaffold(
      // 关键设置：让 Body 内容延伸到 AppBar 后方，即延伸到状态栏区域
      extendBodyBehindAppBar: true,

      body: DefaultTabController(
        length: _tabs.length,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // 1. 顶部标题栏
                SliverAppBar(
                  title: Text(_appBarOpacity > 0.8?'标题栏' : '', style: TextStyle(color: titleColor)),
                  pinned: true,
                  // 动态设置背景色
                  backgroundColor: dynamicBackgroundColor,
                  elevation: _appBarOpacity > 0.0 ? 4.0 : 0.0,

                  // 确保标题栏内容可以在状态栏下显示
                  // 默认情况下，Flutter会自动处理状态栏的 padding，
                  // 配合 extendBodyBehindAppBar: true 即可实现内容延伸。

                ),
                // 2. 内容区域 (现在延伸到了顶部状态栏下方)
                SliverToBoxAdapter(
                  child: Container(
                    // 由于内容区域要覆盖到状态栏，我们需要手动添加状态栏高度的 padding
                    // MediaQuery.of(context).padding.top 获取状态栏高度
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
                    height: _contentHeight + MediaQuery.of(context).padding.top + kToolbarHeight, // 增加高度以覆盖状态栏和标题栏的初始位置
                    color: Colors.blueGrey.shade800,
                    alignment: Alignment.center,
                    child: const Text('内容区域\n(已延伸到状态栏)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),

                // 3. Tab 栏 (吸顶)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.white, // 与标题栏颜色统一，文字用白色
                      unselectedLabelColor: Colors.blue.shade200, // 未选中颜色
                      indicatorColor: Colors.white, // 指示器颜色
                      tabs: _tabs.map((name) => Tab(text: name)).toList(),
                    ),
                    baseColor: baseColor, // 传递基础颜色给 Delegate，确保吸顶后背景色统一
                  ),
                ),
              ];
            },
            // 4. Tab View
            body: TabBarView(
              controller: _tabController,
              children: _tabs.map((name) {
                return ListView.builder(
                  key: PageStorageKey<String>(name),
                  itemCount: 50,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('$name 内容 $index'),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}