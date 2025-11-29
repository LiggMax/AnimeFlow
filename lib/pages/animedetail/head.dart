import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_anime/models/hot_item.dart';

class HeadView extends StatelessWidget {
  final Subject data;

  const HeadView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景图片
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Image.network(data.images.large, fit: BoxFit.cover),
          ),
          // 半透明遮罩层
          Container(color: Colors.black.withValues(alpha: 0.3)),
          // 内容区域
          Positioned(
            // 状态栏高度
            top: MediaQuery.of(context).padding.top,
            left: 15,
            right: 15,
            bottom: 10,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.account_balance_wallet_sharp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(data.images.large),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.nameCN ?? data.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(height: 5),
                            Text(
                              data.info,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
