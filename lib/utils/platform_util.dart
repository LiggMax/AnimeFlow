import 'package:flutter/foundation.dart';

class PlatformUtil {
  /// 判断是否为桌面端
  static bool get isDesktop {
    return defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  ///判断是否位移动端
  static bool get isMobile {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }
}
