import 'dart:ui';

import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';

class HeadDetail extends StatelessWidget {
  final Subject subject;
  final double statusBarHeight;
  final double contentHeight;

  const HeadDetail(
    this.subject, {
    super.key,
    required this.statusBarHeight,
    required this.contentHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Image.network(
              subject.images.large,
              fit: BoxFit.cover,
              height: contentHeight,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        // Positioned.fill(
        //   child: Container(
        //     color: Colors.black.withValues(alpha: 0.3),
        //   ),
        // ),
        Positioned(
          top: statusBarHeight + kToolbarHeight,
          left: 5,
          right: 5,
          bottom: 5,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2, // 海报占2份
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.network(subject.images.large),
                  ),
                ),
                SizedBox(width: 16), // 间距
                Flexible(
                  flex: 3, // 文本占3份
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.nameCN ?? subject.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(subject.info),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ],
    );
  }
}
