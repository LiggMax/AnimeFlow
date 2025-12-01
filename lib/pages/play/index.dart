import 'package:anime_flow/components/video/video.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'content/index.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late Subject subject;

  @override
  void initState() {
    super.initState();
    subject = Get.arguments as Subject;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          // 设置底部导航栏颜色为透明
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      // 延伸到状态栏和导航栏
      extendBody: true,
      body: LayoutBuilder(builder: (context, constraints) {
        // 判断是否为宽屏 (例如大于 600 像素)
        final bool isWideScreen = constraints.maxWidth > 600;

        if (isWideScreen) {
          // 宽屏：水平布局 (左侧内容，右侧播放器)
          return SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  播放区 (比例自适应或固定宽度)
                Expanded(
                  flex: 2,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: const VideoView(),
                    ),
                  ),
                ),
                //  内容区
                Expanded(
                  flex: 1,
                  child: ContentView(subject),
                ),
              ],
            ),
          );
        } else {
          // 窄屏：竖向布局 (顶部播放器，底部内容)
          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                // 1. 播放区
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoView(),
                ),
                // 2. 内容区
                Expanded(
                  child: ContentView(subject),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
