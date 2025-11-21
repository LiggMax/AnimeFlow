import 'package:flutter/material.dart';
import 'package:my_anime/components/Home/category.dart';
import 'package:my_anime/components/Home/hot.dart';
import 'package:my_anime/components/Home/more_list.dart';
import 'package:my_anime/components/Home/carousel.dart';
import 'package:my_anime/components/Home/suggestion.dart';
import 'package:my_anime/models/banner_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [
    BannerItem(id: '1', url: 'https://play.xfvod.pro:8088/images/hb/jdgjj.webp'),
    BannerItem(id: '2', url: 'https://play.xfvod.pro/images/hb/wmbkn.png'),
    BannerItem(id: '3', url: 'https://play.xfvod.pro/images/hb/gyro.png'),
    BannerItem(id: '4', url: 'https://play.xfvod.pro/images/hb/blzh.webp'),
    BannerItem(id: '4', url: 'https://play.xfvod.pro/images/hb/qczt.jpg'),
  ];

  List<Widget> _getScrollChildren() {
    return [
      // 轮播
      SliverToBoxAdapter(child: MySlider(bannerList: _bannerList)),
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
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
