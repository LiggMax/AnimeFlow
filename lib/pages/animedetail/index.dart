import 'package:anime_flow/controllers/title_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Tab A', 'Tab B', 'Tab C'];
  final double _contentHeight = 200.0; // 内容区域的高度
  final TitleController titleController = Get.put(TitleController());
  bool _isPinned = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    titleController.updateTitle("标题");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 基础的AppBar颜色 (例如蓝色)
    const Color baseColor = Colors.blue;
    // 状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // TabBar高度 (标准高度)
    const double tabBarHeight = 46.0;

    return Scaffold(
      // 关键设置：让 Body 内容延伸到 AppBar 后方
      extendBodyBehindAppBar: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.depth == 0 &&
              notification is ScrollUpdateNotification) {
            final bool isPinned = notification.metrics.pixels >= _contentHeight;
            if (_isPinned != isPinned) {
              setState(() {
                _isPinned = isPinned;
              });
            }
          }
          return false;
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title:  AnimatedOpacity(
                      opacity: _isPinned ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        "标题",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  pinned: true,
                  floating: false,
                  snap: false,
                  // 动态设置背景色
                  backgroundColor: baseColor,
                  elevation: _isPinned ? 4.0 : 0.0,
                  forceElevated: _isPinned,

                  // 展开高度计算：内容高度 + 状态栏 + Toolbar + TabBar
                // 这样确保内容区域有足够的空间展示，且不会被 TabBar 遮挡太多
                expandedHeight:
                    _contentHeight +
                    statusBarHeight +
                    kToolbarHeight +
                    tabBarHeight,

                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    // 内容区域
                    padding: EdgeInsets.only(
                      top: statusBarHeight + kToolbarHeight,
                      bottom: tabBarHeight, // 底部留出 TabBar 的空间
                    ),
                    color: Colors.blueGrey.shade800,
                    alignment: Alignment.center,
                    child: const Text(
                      '内容区域\n(已延伸到状态栏)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),

                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(tabBarHeight),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.blue.shade200,
                    indicatorColor: Colors.white,
                    tabs: _tabs.map((name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ),
          ];
        },
        // Body 使用 TabBarView
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((name) {
            return Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    // 注入重叠区域，防止内容被 Header 遮挡
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((
                        BuildContext context,
                        int index,
                      ) {
                        return ListTile(title: Text('$name 内容 $index'));
                      }, childCount: 50),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    ));
  }
}
