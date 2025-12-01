import 'package:anime_flow/components/anime_head_detail/head_detail.dart';
import 'package:anime_flow/http/requests/bgm_request.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:anime_flow/models/subjects_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage>
    with SingleTickerProviderStateMixin {
  late Subject animeDetail;
  late TabController _tabController;
  late Future<SubjectsItem?> _subjectsItem;
  final List<String> _tabs = ['Tab A', 'Tab B', 'Tab C'];
  final double _contentHeight = 200.0; // 内容区域的高度
  bool _isPinned = false;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    animeDetail = Get.arguments;
    _subjectsItem = BgmRequest.getSubjectByIdService(animeDetail.id);
  }
  

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverAppBar(
                  title: AnimatedOpacity(
                    opacity: _isPinned ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      animeDetail.nameCN ?? animeDetail.name,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  pinned: true,
                  floating: false,
                  snap: false,
                  // 动态设置背景色
                  elevation: _isPinned ? 4.0 : 0.0,
                  forceElevated: _isPinned,

                  // 展开高度计算：内容高度 + 状态栏 + Toolbar + TabBar
                  // 这样确保内容区域有足够的空间展示，且不会被 TabBar 遮挡太多
                  expandedHeight: _contentHeight +
                      statusBarHeight +
                      kToolbarHeight +
                      tabBarHeight,

                  /// 头部内容区域
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      padding: EdgeInsets.only(
                        bottom: tabBarHeight, // 底部留出 TabBar 的空间
                      ),
                      // 数据内容
                      child: FutureBuilder<SubjectsItem?>(
                        future: _subjectsItem,
                        builder: (context, snapshot) {
                          return HeadDetail(
                            animeDetail,
                            snapshot.data,
                            statusBarHeight: statusBarHeight,
                            contentHeight: _contentHeight,
                          );
                        },
                      ),
                    ),
                  ),

                  /// TabBar
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(tabBarHeight),
                    child: TabBar(
                      controller: _tabController,
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
      ),
    );
  }
}
