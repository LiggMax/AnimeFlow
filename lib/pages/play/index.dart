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
  final GlobalKey _videoKey = GlobalKey();
  final GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    subject = Get.arguments as Subject;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWideScreen = constraints.maxWidth > 600;
      return isWideScreen
          ? Scaffold(
              body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: VideoView(
                        key: _videoKey,
                        subject: subject,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: ContentView(subject, key: _contentKey),
                ),
              ],
            ))
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.black,
                systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: Colors.transparent,
                ),
              ),
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoView(key: _videoKey, subject: subject),
                    ),
                    Expanded(
                      child: ContentView(subject, key: _contentKey),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
