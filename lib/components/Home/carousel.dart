import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/hot_item.dart';

class MySlider extends StatefulWidget {
  final HotItem bannerList;

  const MySlider({super.key, required this.bannerList});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int _current = 0; //当前轮播图索引
  final CarouselSliderController _controller =
      CarouselSliderController(); //轮播图控制器

  //轮播图
  Widget _getCarousel() {
    // 检查数据是否为空或长度为0
    if (widget.bannerList.data == null || widget.bannerList.data!.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(child: Text('暂无数据')),
      );
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _controller,
      items: List.generate(widget.bannerList.data!.length, (int index) {
        return Image.network(
          widget.bannerList.data![index].subject?.images?.large ?? '',
          fit: BoxFit.cover,
          width: screenWidth,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Icon(Icons.error),
            );
          },
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 5),
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  //搜索输入框
  Widget _search() {
    return Positioned(
      top: 5,
      left: 5,
      right: 5,
      child: SizedBox(
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            iconColor: Colors.white,
            hintText: "搜索...",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            filled: true,
            fillColor: Color.fromRGBO(91, 91, 91, 0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }

  //轮播图指示器
  Widget _dots() {
    // 检查数据是否为空或长度为0
    if (widget.bannerList.data == null || widget.bannerList.data!.isEmpty) {
      return SizedBox.shrink();
    }

    return Positioned(
      right: 5,
      left: 5,
      bottom: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.bannerList.data!.length, (int index) {
          return GestureDetector(
            onTap: () {
              _controller.animateToPage(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 10,
              width: index == _current ? 30 : 20,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _current == index
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(255, 255, 255, 0.4),
              ),
            ),
          );
        }),
      ),
    );
  }

  //底部背景
  Widget _background() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.5),
              Color.fromRGBO(0, 0, 0, 0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  //顶部背景
  Widget _topBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.5),
              Color.fromRGBO(0, 0, 0, 0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getCarousel(),
        _topBackground(),
        _background(),
        _search(),
        _dots(),
      ],
    );
  }
}