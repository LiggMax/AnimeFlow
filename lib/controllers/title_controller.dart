import 'package:get/get.dart';

class TitleController extends GetxController {
  // 当前标题
  final currentTitle = ''.obs;

  void updateTitle(String title) {
    currentTitle.value = title;
  }
}