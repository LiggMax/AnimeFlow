import 'package:flutter/material.dart';
import 'package:my_anime/pages/Cart/index.dart';
import 'package:my_anime/pages/Category/index.dart';
import 'package:my_anime/pages/recommend/index.dart';
import 'package:my_anime/pages/play/index.dart';

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
        selectedIcon: Icon(tab.activeIcon),
        label: tab.title,
      );
    }).toList();
  }

  int _currentIndex = 0;

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const CategoryView();
      case 2:
        return const CartView();
      case 3:
        return const VideoView();
      default:
        return const HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _getCurrentPage(),
      ),
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
