import 'package:get/get.dart';

class TabTitleController extends GetxController {
  var title = ''.obs;

  void setTitle(String newTitle) {
    title.value = newTitle;
  }
}