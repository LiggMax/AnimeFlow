import 'package:flutter/material.dart';
import 'package:my_anime/pages/Cart/index.dart';
import 'package:my_anime/pages/Category/index.dart';
import 'package:my_anime/pages/Home/index.dart';
import 'package:my_anime/pages/Profile/index.dart';

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
      title: "首页",
      icon: Icons.home,
      activeIcon: Icons.home_filled,
      page: const Text("首页"),
    ),
    TabItem(
      type: TabType.category,
      title: "分类",
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
      page: const Text("分类"),
    ),
    TabItem(
      type: TabType.cart,
      title: "购物车",
      icon: Icons.miscellaneous_services_outlined,
      activeIcon: Icons.settings,
      page: const Text("购物车"),
    ),
    TabItem(
      type: TabType.profile,
      title: "我的",
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      page: const Text("我的"),
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

  List<Widget> _getTChildren() {
    return [HomeView(), CategoryView(), CartView(), ProfileView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("主页")),
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getTChildren()),
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).colorScheme.primary,
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
