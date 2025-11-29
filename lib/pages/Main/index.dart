import 'package:flutter/material.dart';
import 'package:anime_flow/pages/Category/index.dart';
import 'package:anime_flow/pages/recommend/index.dart';
import 'package:anime_flow/pages/play/index.dart';

import '../../models/tab_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<TabItem> _tabs = [
    TabItem(
      type: TabType.home,
      title: "推荐",
      icon: Icons.home,
      activeIcon: Icons.home_filled,
    ),
    TabItem(
      type: TabType.category,
      title: "分类",
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
    ),
    TabItem(
      type: TabType.profile,
      title: "视频",
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  List<NavigationDestination> _getTabBarWidget() {
    return _tabs.map((tab) {
      return NavigationDestination(
        icon: Icon(tab.icon),
        selectedIcon: Icon(tab.activeIcon,color: Theme.of(context).primaryColor,),
        label: tab.title,
      );
    }).toList();
  }

  int _currentIndex = 0;

  //TODO 需要做缓存优化
  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const RecommendView();
      case 1:
        return const CategoryView();
      case 2:
        return const VideoView();
      default:
        return const RecommendView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: _getTabBarWidget(),
      ),
    );
  }
}
