import 'package:flutter/material.dart';
import 'package:my_anime/models/hot_item.dart';

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
        : Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1800),
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10, // 横向间距
                  mainAxisSpacing: 10, // 纵向间距
                  childAspectRatio: 0.7, // 宽高比
                ),
                itemCount: _bannerList!.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final dataItem = _bannerList!.data[index].subject;
                  return Card(
                    color: Colors.blue,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        print("点击了${dataItem.nameCN ?? dataItem.name}");
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
  }

  @override
  void initState() {
    super.initState();
    getBannerList(); // 在初始化时调用获取banner列表的方法
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
    return Scaffold(appBar: AppBar(), body: _buildPage());
  }
}
