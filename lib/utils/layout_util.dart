import 'package:flutter/cupertino.dart';

class LayoutUtil {

  static int getCrossAxisCount(BoxConstraints constraints) {
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
}