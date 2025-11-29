import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anime_flow/models/hot_item.dart';

import 'head.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Subject animeData;

  @override
  void initState() {
    super.initState();
    animeData = Get.arguments as Subject;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabList = [Tab(text: '简介'), Tab(text: '评论'), Tab(text: '相关')];

    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  animeData.images.large,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _StickyTab(tabList: tabList),
              pinned: true, // 添加这行使Tab吸顶
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Center(child: Text('简介')),
                  Center(child: Text('评论')),
                  Center(child: Text('相关')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyTab extends SliverPersistentHeaderDelegate {
  final List<Tab> tabList;

  _StickyTab({required this.tabList});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: TabBar(tabs: tabList),
    );
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}