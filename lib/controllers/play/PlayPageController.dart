import 'package:get/get.dart';

class PlayPageController extends GetxController {
  var isWideScreen = false.obs;

  void updateIsWideScreen(bool value) {
    isWideScreen.value = value;
  }
}
