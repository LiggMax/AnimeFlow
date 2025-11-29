import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_anime/routes/index.dart';
import 'package:my_anime/controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    // 初始化主题
    themeController.initTheme();

    return GetBuilder<ThemeController>(
      builder: (controller) {
        return GetMaterialApp(
          theme: ThemeController.lightTheme,
          darkTheme: ThemeController.darkTheme,
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: "/",
          routes: getRootRoutes(),
        );
      },
    );
  }
}
