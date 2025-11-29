import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anime_flow/controllers/theme_controller.dart';
import 'package:anime_flow/models/hot_item.dart';

import '../../api/hot.dart';

class RecommendView extends StatefulWidget {
  const RecommendView({super.key});

  @override
  State<RecommendView> createState() => _RecommendViewState();
}

class _RecommendViewState extends State<RecommendView> {
  HotItem? _bannerList;

  Widget _buildPage() {
    return _bannerList == null
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1800),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getCrossAxisCount(constraints),
                      crossAxisSpacing: 5, // 横向间距
                      mainAxisSpacing: 5, // 纵向间距
                      childAspectRatio: 0.7, // 宽高比
                    ),
                    itemCount: _bannerList!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final dataItem = _bannerList!.data[index].subject;
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed("/anime_detail", arguments: dataItem);
                          },
                          highlightColor: Colors.white.withOpacity(0.1),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Image.network(
                                  dataItem.images.large,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        //从灰到白
                                        Colors.black38,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    dataItem.nameCN ?? dataItem.name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }

  @override
  void initState() {
    super.initState();
    getBannerList(); // 在初始化时调用获取banner列表的方法
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    double screenWidth = constraints.maxWidth;
    if (screenWidth > 1200) {
      return 6; // 大屏幕
    } else if (screenWidth > 900) {
      return 5; // 中大屏幕
    } else if (screenWidth > 600) {
      return 4; // 平板
    } else if (screenWidth > 400) {
      return 3; // 较大手机屏
    } else {
      return 3; // 较小手机屏
    }
  }

  void getBannerList() async {
    try {
      final bannerList = await getHotApi(20, 0);
      if (mounted) {
        setState(() {
          _bannerList = bannerList;
        });
      }
    } catch (e) {
      print('获取Banner列表失败: $e');
      // 即使出错也要更新状态，避免无限loading
      if (mounted) {
        setState(() {
          _bannerList = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: Text("推荐")),
            GetBuilder<ThemeController>(
              builder: (controller) {
                return IconButton(
                  icon: Icon(
                    controller.isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
                    color: controller.isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    controller.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: _buildPage(),
    );
  }
}
