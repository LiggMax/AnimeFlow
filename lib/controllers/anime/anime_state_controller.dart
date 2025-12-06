import 'package:get/get.dart';

class AnimeStateController extends GetxController {
  final RxString animeName = ''.obs;

  void setAnimeName(String name) {
    animeName.value = name;
  }
}
