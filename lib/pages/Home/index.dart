import 'package:flutter/material.dart';
import 'package:my_anime/components/Home/category.dart';
import 'package:my_anime/components/Home/hot.dart';
import 'package:my_anime/components/Home/more_list.dart';
import 'package:my_anime/components/Home/carousel.dart';
import 'package:my_anime/components/Home/suggestion.dart';
import 'package:my_anime/models/hot_item.dart';

import '../../api/hot.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HotItem? _bannerList;

  List<Widget> _getScrollChildren() {
    return [
      // 轮播
      SliverToBoxAdapter(
        child: _bannerList == null
            ? SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            : MySlider(bannerList: _bannerList!),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 分类
      SliverToBoxAdapter(child: Category()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Suggestion(),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 爆款推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hot()),
              SizedBox(width: 10),
              Expanded(child: Hot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 商品内容
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        sliver: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return MoreList(index: index);
          },
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getBannerList(); // 在初始化时调用获取banner列表的方法
  }

  void getBannerList() async {
    final bannerList = await getHotApi(6, 0);
    if (mounted) {
      setState(() {
        _bannerList = bannerList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
