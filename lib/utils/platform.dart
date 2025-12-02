import 'package:flutter/foundation.dart';

class Platform {
  /// 判断是否为桌面端
  static bool get isDesktop {
    return defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }
}