import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';

import 'introduce.dart';

class ContentView extends StatefulWidget {
  final Subject subject;

  const ContentView(this.subject, {super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['简介', '评论'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: _tabs.map((name) => Tab(text: name)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                IntroduceView(widget.subject),
                Text('评论'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
