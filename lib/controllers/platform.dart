import 'package:flutter/foundation.dart';

class PlatformController {
  /// 获取当前平台类型
  static TargetPlatform getCurrentPlatform() {
    return defaultTargetPlatform;
  }

  /// 判断是否为 Android 平台
  static bool isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  /// 判断是否为 iOS 平台
  static bool isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// 判断是否为 Web 平台
  static bool isWeb() {
    return kIsWeb;
  }

  /// 判断是否为桌面平台 (Windows/macOS/Linux)
  static bool isDesktop() {
    return isWindows() || isMacOS() || isLinux();
  }

  /// 判断是否为 Windows 平台
  static bool isWindows() {
    return defaultTargetPlatform == TargetPlatform.windows;
  }

  /// 判断是否为 macOS 平台
  static bool isMacOS() {
    return defaultTargetPlatform == TargetPlatform.macOS;
  }

  /// 判断是否为 Linux 平台
  static bool isLinux() {
    return defaultTargetPlatform == TargetPlatform.linux;
  }
}
